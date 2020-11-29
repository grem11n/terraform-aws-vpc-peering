# Providers are required because of cross-region
provider "aws" {
  alias  = "this"
  region = var.region
}

provider "aws" {
  alias  = "peer"
  region = var.region
}

locals {
  this_region = data.aws_region.this.name
  peer_region = data.aws_region.peer.name

  same_region            = data.aws_region.this.name == data.aws_region.peer.name
  same_account           = data.aws_caller_identity.this.account_id == data.aws_caller_identity.peer.account_id
  same_acount_and_region = local.same_region && local.same_account

  # Rout table should either be the one for the vpc, or the ones associated to the subnets if subnets are given
  this_rts_ids_new = data.aws_route_tables.this_vpc_rts.ids
  peer_rts_ids_new = data.aws_route_tables.peer_vpc_rts.ids

  this_rts_ids = length(var.this_subnets_ids) == 0 ? local.this_rts_ids_new : data.aws_route_table.this_subnet_rts[*].route_table_id
  peer_rts_ids = length(var.peer_subnets_ids) == 0 ? local.peer_rts_ids_new : data.aws_route_table.peer_subnet_rts[*].route_table_id

  # Destination cidrs for this are in peer and vice versa
  this_dest_cidrs = length(var.peer_subnets_ids) == 0 ? toset([data.aws_vpc.peer_vpc.cidr_block]) : toset(data.aws_subnet.peer[*].cidr_block)
  peer_dest_cidrs = length(var.this_subnets_ids) == 0 ? toset([data.aws_vpc.this_vpc.cidr_block]) : toset(data.aws_subnet.this[*].cidr_block)

  # In each route table there should be 1 route for each subnet, so combining the two sets
  this_routes = [
    for pair in setproduct(local.this_rts_ids, local.this_dest_cidrs) : {
      rts_id    = pair[0]
      dest_cidr = pair[1]
    }
  ]

  # In each route table there should be 1 route for each subnet, so combining the two sets
  peer_routes = [
    for pair in setproduct(local.peer_rts_ids, local.peer_dest_cidrs) : {
      rts_id    = pair[0]
      dest_cidr = pair[1]
    }
  ]
}

##########################
# VPC peering connection #
##########################
resource "aws_vpc_peering_connection" "this" {
  provider      = aws.this
  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = var.this_vpc_id
  peer_region   = data.aws_region.peer.name
  tags          = merge(var.tags, map("Side", local.same_acount_and_region ? "Both" : "Requester"))
}

######################################
# VPC peering accepter configuration #
######################################
resource "aws_vpc_peering_connection_accepter" "peer_accepter" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
  auto_accept               = var.auto_accept_peering
  tags                      = merge(var.tags, map("Side", local.same_acount_and_region ? "Both" : "Accepter"))
}

#######################
# VPC peering options #
#######################
resource "aws_vpc_peering_connection_options" "this" {
  provider                  = aws.this
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.peer_accepter.id

  requester {
    allow_remote_vpc_dns_resolution  = var.this_dns_resolution
    allow_classic_link_to_remote_vpc = var.this_link_to_peer_classic
    allow_vpc_to_remote_classic_link = var.this_link_to_local_classic
  }
}

resource "aws_vpc_peering_connection_options" "accepter" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.peer_accepter.id

  accepter {
    allow_remote_vpc_dns_resolution  = var.peer_dns_resolution
    allow_classic_link_to_remote_vpc = var.peer_link_to_peer_classic
    allow_vpc_to_remote_classic_link = var.peer_link_to_local_classic
  }
}

###################
# This VPC Routes #  Route from THIS route table to PEER cidr
###################
resource "aws_route" "this_routes" {
  provider = aws.this
  # Only create routes for this route table if input dictates it, and in that case, for all combinations
  count                     = var.from_this ? length(local.this_routes) : 0
  route_table_id            = local.this_routes[count.index].rts_id
  destination_cidr_block    = local.this_routes[count.index].dest_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

###################
# Peer VPC Routes #  Route from PEER route table to THIS cidr
###################
resource "aws_route" "peer_routes" {
  provider = aws.peer
  # Only create routes for peer route table if input dictates it, and in that case, for all combinations
  count                     = var.from_peer ? length(local.peer_routes) : 0
  route_table_id            = local.peer_routes[count.index].rts_id
  destination_cidr_block    = local.peer_routes[count.index].dest_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}
