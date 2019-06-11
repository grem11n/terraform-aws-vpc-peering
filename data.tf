data "aws_caller_identity" "this" {
  provider = "aws.this"
}
data "aws_region" "this" {
  provider = "aws.this"
}

data "aws_caller_identity" "peer" {
  provider = "aws.peer"
}
data "aws_region" "peer" {
  provider = "aws.peer"
}

data "aws_vpc" "this_vpc" {
  provider = "aws.this"
  id       = var.this_vpc_id
}

data "aws_vpc" "peer_vpc" {
  provider = "aws.peer"
  id       = var.peer_vpc_id
}

data "aws_route_tables" "this_vpc_rts" {
  provider = "aws.this"
  vpc_id   = var.this_vpc_id
}

data "aws_route_tables" "peer_vpc_rts" {
  provider = "aws.peer"
  vpc_id   = var.peer_vpc_id
}
