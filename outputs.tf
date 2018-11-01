locals {
  vpc_peering_id        = "${compact(concat(coalescelist(aws_vpc_peering_connection.this.*.id, aws_vpc_peering_connection.this_cross_region.*.id), list("")))}"
  peering_accept_status = "${compact(concat(coalescelist(aws_vpc_peering_connection.this.*.accept_status, aws_vpc_peering_connection.this_cross_region.*.accept_status), list("")))}"
  this_vpc_route_tables = "${compact(concat(data.aws_route_tables.this_vpc_rts.ids, list("")))}"
  peer_vpc_route_tables = "${compact(concat(data.aws_route_tables.peer_vpc_rts.ids, list("")))}"
}

output "vpc_peering_id" {
  description = "Peering connection ID"
  value       = ["${local.vpc_peering_id}"]
}

output "vpc_peering_accept_status" {
  description = "Accept status for the connection"
  value       = ["${local.peering_accept_status}"]
}

output "this_vpc_route_tables" {
  description = "Private route tables"
  value       = ["${local.this_vpc_route_tables}"]
}

output "peer_vpc_route_table" {
  description = "Public route tables"
  value       = ["${local.peer_vpc_route_tables}"]
}
