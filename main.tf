# Providers are required because of cross-region
provider "aws" {
  alias = "this"
}

provider "aws" {
  alias = "peer"
}

##########################
# VPC peering connection #
##########################
resource "aws_vpc_peering_connection" "this" {
  provider      = "aws.this"
  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = var.this_vpc_id
  peer_region   = data.aws_region.peer.name
  tags          = var.tags
}

######################################
# VPC peering accepter configuration #
######################################
resource "aws_vpc_peering_connection_accepter" "peer_accepter" {
  provider                  = "aws.peer"
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
  auto_accept               = var.auto_accept_peering
  tags                      = merge(var.tags, map("Side", "Accepter"))
}

#######################
# VPC peering options #
#######################
resource "aws_vpc_peering_connection_options" "this" {
  provider                  = "aws.this"
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.peer_accepter.id

  # See https://github.com/terraform-providers/terraform-provider-aws/issues/6730
  # Until this is fixed, we must not try and set any options for cross-region peering.
  count = data.aws_region.this.name == data.aws_region.peer.name ? 1 : 0

  requester {
    allow_remote_vpc_dns_resolution  = var.this_dns_resolution
    allow_classic_link_to_remote_vpc = var.this_link_to_peer_classic
    allow_vpc_to_remote_classic_link = var.this_link_to_local_classic
  }
}

resource "aws_vpc_peering_connection_options" "accepter" {
  provider                  = "aws.peer"
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.peer_accepter.id

  # See https://github.com/terraform-providers/terraform-provider-aws/issues/6730
  # Until this is fixed, we must not try and set any options for cross-region peering.
  count = data.aws_region.this.name == data.aws_region.peer.name ? 1 : 0

  accepter {
    allow_remote_vpc_dns_resolution  = var.peer_dns_resolution
    allow_classic_link_to_remote_vpc = var.peer_link_to_peer_classic
    allow_vpc_to_remote_classic_link = var.peer_link_to_local_classic
  }
}

###################
# This VPC Routes #
###################
resource "aws_route" "this_routes_region" {
  provider                  = "aws.this"
  count                     = length(data.aws_route_tables.this_vpc_rts.ids)
  route_table_id            = tolist(data.aws_route_tables.this_vpc_rts.ids)[count.index]
  destination_cidr_block    = data.aws_vpc.peer_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

###################
# Peer VPC Routes #
###################
resource "aws_route" "peer_routes_region" {
  provider                  = "aws.peer"
  count                     = length(data.aws_route_tables.peer_vpc_rts.ids)
  route_table_id            = tolist(data.aws_route_tables.peer_vpc_rts.ids)[count.index]
  destination_cidr_block    = data.aws_vpc.this_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}
