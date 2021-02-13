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

  # `this_dest_cidrs` represent CIDR of peer VPC, therefore a destination CIDR for this_vpc
  # `peer_dest_cidrs` represent CIDR of this VPC, therefore a destination CIDR for peer_vpc
  # Destination cidrs for this are in peer and vice versa
  this_dest_cidrs = length(var.peer_subnets_ids) == 0 ? toset([data.aws_vpc.peer_vpc.cidr_block]) : toset(data.aws_subnet.peer[*].cidr_block)
  peer_dest_cidrs = length(var.this_subnets_ids) == 0 ? toset([data.aws_vpc.this_vpc.cidr_block]) : toset(data.aws_subnet.this[*].cidr_block)

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
}
