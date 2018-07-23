output "vpc_peering_id" {
  description = "Peering connection ID"
  value       = "${var.peering_id == "" ? element(concat(aws_vpc_peering_connection.this.*.id, list("")), 0) : var.peering_id}"
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
