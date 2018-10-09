locals {
  vpc_peering_id        = "${compact(concat(coalescelist(aws_vpc_peering_connection.this.*.id, aws_vpc_peering_connection.this_cross_region.*.id), list("")))}"
  peering_accept_status = "${compact(concat(coalescelist(aws_vpc_peering_connection.this.*.accept_status, aws_vpc_peering_connection.this_cross_region.*.accept_status), list("")))}"
  private_route_tables  = "${compact(concat(coalescelist(var.private_route_table_ids), list("")))}"
  public_route_tables   = "${compact(concat(coalescelist(var.private_route_table_ids), list("")))}"
}

output "vpc_peering_id" {
  description = "Peering connection ID"
  value       = ["${local.vpc_peering_id}"]
}

output "vpc_peering_accept_status" {
  description = "Accept status for the connection"
  value       = ["${local.peering_accept_status}"]
}

output "private_route_tables" {
  description = "Private route tables"
  value       = ["${local.private_route_tables}"]
}

output "public_route_table" {
  description = "Public route tables"
  value       = ["${local.public_route_table_ids}"]
}

output "peer_cidr_block" {
  description = "Peer CIDR block"
  value       = "${var.peer_cidr_block}"
}
