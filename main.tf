##########################
# VPC peering connection #
##########################
resource "aws_vpc_peering_connection" "this" {
  count         = "${(var.create_peering * (1 + var.cross_region_peering)) == "1" ? 1 : 0}"
  peer_owner_id = "${var.owner_account_id == "" ? data.aws_caller_identity.current.account_id : var.owner_account_id}"
  peer_vpc_id   = "${var.vpc_peer_id}"
  vpc_id        = "${var.this_vpc_id}"
  auto_accept   = "${var.auto_accept_peering}"
  tags          = "${var.tags}"
}

##################
# Private routes #
##################
resource "aws_route" "private_route_table" {
  count                     = "${length(var.private_route_table_ids)}"
  route_table_id            = "${element(var.private_route_table_ids, count.index)}"
  destination_cidr_block    = "${var.peer_cidr_block}"
  vpc_peering_connection_id = "${var.peering_id == "" ? element(concat(aws_vpc_peering_connection.this.*.id, list("")), 0) : var.peering_id}"
}

#################
# Public routes #
#################
resource "aws_route" "public_route_table" {
  count                     = "${length(var.public_route_table_ids)}"
  route_table_id            = "${element(var.public_route_table_ids, count.index)}"
  destination_cidr_block    = "${var.peer_cidr_block}"
  vpc_peering_connection_id = "${var.peering_id == "" ? element(concat(aws_vpc_peering_connection.this.*.id, list("")), 0) : var.peering_id}"
}

############################
# VPC cross-region peering #
############################
resource "aws_vpc_peering_connection" "this_cross_region" {
  count         = "${(var.create_peering * var.cross_region_peering) == "1" ? 1 : 0}"
  peer_owner_id = "${var.owner_account_id == "" ? data.aws_caller_identity.current.account_id : var.owner_account_id}"
  peer_vpc_id   = "${var.vpc_peer_id}"
  vpc_id        = "${var.this_vpc_id}"
  peer_region   = "${var.peer_region}"
}

#####################################
# Accepter's side of the connection #
#####################################
resource "aws_vpc_peering_connection_accepter" "peer_aacepter" {
  provider                  = "aws.peer"
  count                     = "${(var.create_peering * var.cross_region_peering) == "1" ? 1 : 0}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.this_cross_region.id}"
  auto_accept               = true
  tags                      = "${merge(var.tags, map("Side", "Accepter"))}"
}
