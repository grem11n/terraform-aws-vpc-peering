locals {
  this_region = data.aws_region.this.name
  peer_region = data.aws_region.peer.name

  same_region            = data.aws_region.this.name == data.aws_region.peer.name
  same_account           = data.aws_caller_identity.this.account_id == data.aws_caller_identity.peer.account_id
  same_acount_and_region = local.same_region && local.same_account

  # Rout table should either be the one for the vpc, or the ones associated to the subnets if subnets are given
  this_subnet_route_table_map = {
    for subnet in data.aws_subnets.this.ids :
    subnet => concat(
      data.aws_route_tables.this_associated_route_tables[subnet].ids,
      [data.aws_route_table.this_main_route_table.id]
    )[0]
  }

  peer_subnet_route_table_map = {
    for subnet in data.aws_subnets.peer.ids :
    subnet => concat(
      data.aws_route_tables.peer_associated_route_tables[subnet].ids,
      [data.aws_route_table.peer_main_route_table.id]
    )[0]
  }

  this_rts_ids = length(var.this_subnets_ids) == 0 ? distinct(values(local.this_subnet_route_table_map)) : distinct([
    for subnet_id in var.this_subnets_ids : local.this_subnet_route_table_map[subnet_id]
  ])

  peer_rts_ids = length(var.peer_subnets_ids) == 0 ? distinct(values(local.peer_subnet_route_table_map)) : distinct([
    for subnet_id in var.peer_subnets_ids : local.peer_subnet_route_table_map[subnet_id]
  ])

  # `this_dest_cidrs` represent CIDR of peer VPC, therefore a destination CIDR for this_vpc
  # `peer_dest_cidrs` represent CIDR of this VPC, therefore a destination CIDR for peer_vpc
  # Destination cidrs for this are in peer and vice versa
  this_dest_cidrs = length(var.peer_subnets_ids) == 0 ? toset([data.aws_vpc.peer_vpc.cidr_block]) : toset(data.aws_subnet.peer[*].cidr_block)
  peer_dest_cidrs = length(var.this_subnets_ids) == 0 ? toset([data.aws_vpc.this_vpc.cidr_block]) : toset(data.aws_subnet.this[*].cidr_block)

  # Get associated CIDR blocks
  this_associated_dest_cidrs = toset(tolist([for k, v in data.aws_vpc.peer_vpc.cidr_block_associations : v.cidr_block]))
  peer_associated_dest_cidrs = toset(tolist([for k, v in data.aws_vpc.this_vpc.cidr_block_associations : v.cidr_block]))

  # Allow specifying route tables explicitly
  this_rts_ids_hack = length(var.this_rts_ids) == 0 ? local.this_rts_ids : var.this_rts_ids
  peer_rts_ids_hack = length(var.peer_rts_ids) == 0 ? local.peer_rts_ids : var.peer_rts_ids

  # In each route table there should be 1 route for each subnet, so combining the two sets
  this_routes = [
    for pair in setproduct(local.this_rts_ids_hack, local.this_dest_cidrs) : {
      rts_id    = pair[0]
      dest_cidr = pair[1]
    }
  ]

  # In each route table there should be 1 route for each subnet, so combining the two sets
  peer_routes = [
    for pair in setproduct(local.peer_rts_ids_hack, local.peer_dest_cidrs) : {
      rts_id    = pair[0]
      dest_cidr = pair[1]
    }
  ]



  # Routes for associated subnets
  this_associated_routes = [
    for pair in setproduct(local.this_rts_ids_hack, local.this_associated_dest_cidrs) : {
      rts_id    = pair[0]
      dest_cidr = pair[1]
    }
  ]

  # In each route table there should be 1 route for each subnet, so combining the two sets
  peer_associated_routes = [
    for pair in setproduct(local.peer_rts_ids_hack, local.peer_associated_dest_cidrs) : {
      rts_id    = pair[0]
      dest_cidr = pair[1]
    }
  ]

  create_associated_routes_this = var.from_this && var.from_this_associated
  create_associated_routes_peer = var.from_peer && var.from_peer_associated
  create_routes_this            = var.from_this && !local.create_associated_routes_this
  create_routes_peer            = var.from_peer && !local.create_associated_routes_peer
}
