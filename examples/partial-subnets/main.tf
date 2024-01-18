/*
/ To make it unit testable, get required parameters from vpcs.
*/

# peer vpc main route table
data "aws_route_table" "peer_main_route_table" {
  provider  = aws.peer
  vpc_id   = var.peer_vpc_id
  filter {
    name   = "association.main"
    values = ["true"]
  } 
}

# peer subnets
data "aws_subnets" "peer" {
  provider  = aws.peer
  filter {
    name   = "vpc-id"
    values = [var.peer_vpc_id]
  }
}

# get route tables associated with subnets
data "aws_route_tables" "peer_associated_route_tables" {
  for_each = { for subnet in data.aws_subnets.peer.ids: subnet => subnet }
  provider = aws.peer
  vpc_id   = var.peer_vpc_id
  filter {
    name   = "association.subnet-id"
    values = [each.key]
  }
}

locals {
  peer_subnet_route_table_map = {
    for subnet in data.aws_subnets.peer.ids: 
      subnet => concat(
        data.aws_route_tables.peer_associated_route_tables[subnet].ids,
        [data.aws_route_table.peer_main_route_table.id]
      )[0]
  }
  peer_subnets_associated_map = {
    for subnet, route_table in local.peer_subnet_route_table_map: 
      subnet => route_table 
      if route_table != data.aws_route_table.peer_main_route_table.id
  }

  peer_subnets_unassociated_map = {
    for subnet, route_table in local.peer_subnet_route_table_map: 
      subnet => route_table 
      if route_table == data.aws_route_table.peer_main_route_table.id
  }
  peer_subnet_ids = distinct(concat(
    try(slice(keys(local.peer_subnets_associated_map), 0, 1), []),
    try(slice(keys(local.peer_subnets_unassociated_map),0, 1), []), 
  ))
  # actually, peer route tables should be detected from peer subnets if specified
  peer_route_tables = distinct([ for subnet in local.peer_subnet_ids: local.peer_subnet_route_table_map[subnet] ])
}




module "partial_subnets" {
  
  source  = "../../"
  #version = "6.0.0"

  providers = {
    aws.this = aws.this
    aws.peer = aws.peer
  }

  this_vpc_id = var.this_vpc_id
  peer_vpc_id = var.peer_vpc_id

  auto_accept_peering = true
  peer_dns_resolution = true
  this_dns_resolution = true  
  peer_subnets_ids = length(var.peer_subnets_ids) > 0 ? var.peer_subnets_ids : local.peer_subnet_ids
  this_subnets_ids = var.this_subnets_ids
  this_rts_ids = var.this_rts_ids
  peer_rts_ids = length(var.peer_rts_ids)>0 ? var.peer_rts_ids : local.peer_route_tables

  tags = {
    Name        = "tf-partial-subnets"
    Environment = "Test"
  }
  # use_maps = true
}
