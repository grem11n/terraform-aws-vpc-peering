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


# Get subnets and route tables from this

# this vpc main route table
data "aws_route_table" "this_main_route_table" {
  provider = aws.this
  vpc_id   = var.this_vpc_id
  filter {
    name   = "association.main"
    values = ["true"]
  }
}

# this subnets
data "aws_subnets" "this" {
  provider = aws.this
  filter {
    name   = "vpc-id"
    values = [var.this_vpc_id]
  }
}

# get route tables associated with subnets
data "aws_route_tables" "this_associated_route_tables" {
  for_each = { for subnet in data.aws_subnets.this.ids : subnet => subnet }
  provider = aws.this
  vpc_id   = var.this_vpc_id
  filter {
    name   = "association.subnet-id"
    values = [each.key]
  }
}


# Get subnets and route tables from peer

# peer vpc main route table
data "aws_route_table" "peer_main_route_table" {
  provider = aws.peer
  vpc_id   = var.peer_vpc_id
  filter {
    name   = "association.main"
    values = ["true"]
  }
}

# peer subnets
data "aws_subnets" "peer" {
  provider = aws.peer
  filter {
    name   = "vpc-id"
    values = [var.peer_vpc_id]
  }
}

# get route tables associated with subnets
data "aws_route_tables" "peer_associated_route_tables" {
  for_each = { for subnet in data.aws_subnets.peer.ids : subnet => subnet }
  provider = aws.peer
  vpc_id   = var.peer_vpc_id
  filter {
    name   = "association.subnet-id"
    values = [each.key]
  }
}

