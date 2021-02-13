# Get account and region info
data "aws_caller_identity" "this" {
  provider = aws.this
}
data "aws_region" "this" {
  provider = aws.this
}
data "aws_caller_identity" "peer" {
  provider = aws.peer
}
data "aws_region" "peer" {
  provider = aws.peer
}

# Get vpc info
data "aws_vpc" "this_vpc" {
  provider = aws.this
  id       = var.this_vpc_id
}
data "aws_vpc" "peer_vpc" {
  provider = aws.peer
  id       = var.peer_vpc_id
}

# Get all route tables from vpcs
data "aws_route_tables" "this_vpc_rts" {
  provider = aws.this
  vpc_id   = var.this_vpc_id
}
data "aws_route_tables" "peer_vpc_rts" {
  provider = aws.peer
  vpc_id   = var.peer_vpc_id
}

# get subnets info
data "aws_subnet" "this" {
  count    = length(var.this_subnets_ids)
  provider = aws.this
  id       = var.this_subnets_ids[count.index]
}
data "aws_subnet" "peer" {
  count    = length(var.peer_subnets_ids)
  provider = aws.peer
  id       = var.peer_subnets_ids[count.index]
}

# Get info for only those route tables associated with the given subnets
data "aws_route_table" "this_subnet_rts" {
  count     = length(var.this_subnets_ids)
  provider  = aws.this
  subnet_id = var.this_subnets_ids[count.index]
}

data "aws_route_table" "peer_subnet_rts" {
  count     = length(var.peer_subnets_ids)
  provider  = aws.peer
  subnet_id = var.peer_subnets_ids[count.index]
}
