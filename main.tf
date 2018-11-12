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
  count         = "${(var.create_peering * (1 + var.cross_region_peering)) == "1" ? 1 : 0}"
  peer_owner_id = "${var.owner_account_id == "" ? data.aws_caller_identity.current.account_id : var.owner_account_id}"
  peer_vpc_id   = "${var.peer_vpc_id}"
  vpc_id        = "${var.this_vpc_id}"
  auto_accept   = "${var.auto_accept_peering}"
  tags          = "${var.tags}"
}

###################
# This VPC Routes #
###################
resource "aws_route" "this_routes_region" {
  provider                  = "aws.this"
  count                     = "${(var.create_peering * (1 + var.cross_region_peering)) == 1 ? length(data.aws_route_tables.peer_vpc_rts.ids) : 0}"
  route_table_id            = "${data.aws_route_tables.this_vpc_rts.ids[count.index]}"
  destination_cidr_block    = "${data.aws_vpc.peer_vpc.cidr_block}"
  vpc_peering_connection_id = "${var.peering_id == "" ? element(concat(aws_vpc_peering_connection.this.*.id, list("")), 0) : var.peering_id}"
}

###################
# Peer VPC Routes #
###################
resource "aws_route" "peer_routes_region" {
  provider                  = "aws.peer"
  count                     = "${(var.create_peering * (1 + var.cross_region_peering)) == 1 ? length(data.aws_route_tables.peer_vpc_rts.ids) : 0}"
  route_table_id            = "${data.aws_route_tables.peer_vpc_rts.ids[count.index]}"
  destination_cidr_block    = "${data.aws_vpc.this_vpc.cidr_block}"
  vpc_peering_connection_id = "${var.peering_id == "" ? element(concat(aws_vpc_peering_connection.this.*.id, list("")), 0) : var.peering_id}"
}

############################
# VPC cross-region peering #
############################
resource "aws_vpc_peering_connection" "this_cross_region" {
  provider      = "aws.this"
  count         = "${(var.create_peering * var.cross_region_peering) == "1" ? 1 : 0}"
  peer_owner_id = "${var.owner_account_id == "" ? data.aws_caller_identity.current.account_id : var.owner_account_id}"
  peer_vpc_id   = "${var.peer_vpc_id}"
  vpc_id        = "${var.this_vpc_id}"
  peer_region   = "${var.peer_region}"
}

#####################################
# Accepter's side of the connection #
#####################################
resource "aws_vpc_peering_connection_accepter" "peer_accepter" {
  provider                  = "aws.peer"
  count                     = "${(var.create_peering * var.cross_region_peering) == "1" ? 1 : 0}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.this_cross_region.id}"
  auto_accept               = true
  tags                      = "${merge(var.tags, map("Side", "Accepter"))}"
}

###################
# This Cross Region VPC Routes #
###################
resource "aws_route" "this_routes_cross_region" {
  provider                  = "aws.this"
  count                     = "${(var.create_peering * var.cross_region_peering) == "1" ? length(data.aws_route_tables.peer_vpc_rts.ids) : 0}"
  route_table_id            = "${data.aws_route_tables.this_vpc_rts.ids[count.index]}"
  destination_cidr_block    = "${data.aws_vpc.peer_vpc.cidr_block}"
  vpc_peering_connection_id = "${var.peering_id == "" ? element(concat(aws_vpc_peering_connection.this_cross_region.*.id, list("")), 0) : var.peering_id}"
}

###################
# Peer Cross Region VPC Routes #
###################
resource "aws_route" "peer_routes_cross_region" {
  provider                  = "aws.peer"
  count                     = "${(var.create_peering * var.cross_region_peering) == "1" ? length(data.aws_route_tables.peer_vpc_rts.ids) : 0}"
  route_table_id            = "${data.aws_route_tables.peer_vpc_rts.ids[count.index]}"
  destination_cidr_block    = "${data.aws_vpc.this_vpc.cidr_block}"
  vpc_peering_connection_id = "${var.peering_id == "" ? element(concat(aws_vpc_peering_connection.this_cross_region.*.id, list("")), 0) : var.peering_id}"
}
