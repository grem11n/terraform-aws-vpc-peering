data "aws_caller_identity" "current" {}

data "aws_vpc" "this_vpc" {
  id = "${var.this_vpc_id}"
}

data "aws_vpc" "peer_vpc" {
  id = "${var.peer_vpc_id}"
}

data "aws_route_tables" "this_vpc_rts" {
  vpc_id = "${var.this_vpc_id}"
}

data "aws_route_tables" "peer_vpc_rts" {
  vpc_id = "${var.peer_vpc_id}"
}
