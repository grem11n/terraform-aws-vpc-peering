output "vpc_peering_id" {
  description = "Peering connection ID"
  value       = "${var.peering_id == "" ? element(concat(aws_vpc_peering_connection.this.*.id, list("")), 0) : var.peering_id}"
}

output "local_vpc_peering_accept_status" {
  description = "Accept status for the connection"
  value       = "${element(concat(aws_vpc_peering_connection.this.*.id, list("")), 0) == "" ? "No local peering" : element(concat(aws_vpc_peering_connection.this.*.accept_status, list("")), 0)}"
}

output "cross_region_peering_connection_id" {
  description = "Cross Region Peering ID"
  value       = "${var.cross_region_peering == 0 ? "No cross-region peering" : element(concat(aws_vpc_peering_connection.this_cross_region.*.id, list("")), 0)}"
}

output "cross_region_peering_accept_status" {
  description = "Cross Region Peering Status"
  value       = "${var.cross_region_peering * var.create_peering == 0 ? "No cross-region peering" : element(concat(aws_vpc_peering_connection.this_cross_region.*.accept_status, list("")), 0)}"
}

output "private_route_tables" {
  description = "Private route tables"
  value       = ["${var.private_route_table_ids}"]
}

output "public_route_table" {
  description = "Public route tables"
  value       = ["${var.public_route_table_ids}"]
}

output "peer_cidr_block" {
  description = "Peer CIDR block"
  value       = "${var.peer_cidr_block}"
}
