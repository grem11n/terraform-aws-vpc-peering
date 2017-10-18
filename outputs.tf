output "vpc_peering_id" {
  description = "Peering connection ID"
  value       = "${aws_vpc_peering_connection.this.id}"
}

output "private_route_tables" {
  description = "Private route tables"
  value       = ["${var.private_route_table_ids}"]
}

output "public_route_table" {
  description = "Public route tables"
  value       = ["${var.public_route_table_ids}"]
}

output "peer_cird_block" {
  description = "Peer CIDR block"
  value       = "${var.peer_cird_block}"
}
