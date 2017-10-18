##########################
# VPC peering connection #
##########################
resource "aws_vpc_peering_connection" "this" {
  peer_owner_id = "${var.owner_account_id}"
  peer_vpc_id   = "${var.vpc_peer_id}"
  vpc_id        = "${var.this_vpc_id}"
  auto_accept   = "${var.auto_accept_peering}"
}

##################
# Private routes #
##################
resource "aws_route" "private_route_table" {
  count = "${length(var.private_route_table_ids)}"

  route_table_id            = "${element(var.private_route_table_ids, count.index)}"
  destination_cidr_block    = "${var.peer_cird_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.this.id}"
  depends_on                = ["aws_vpc_peering_connection.this"]
}

#################
# Public routes #
#################
resource "aws_route" "public_route_table" {
  count = "${length(var.public_route_table_ids) > 0 ? 1: 0}"

  route_table_id            = "${element(var.public_route_table_ids, count.index)}"
  destination_cidr_block    = "${var.peer_cird_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.this.id}"
  depends_on                = ["aws_vpc_peering_connection.this"]
}
