locals {
  this_vpc_route_tables = "${compact(concat(data.aws_route_tables.this_vpc_rts.ids, list("")))}"
  peer_vpc_route_tables = "${compact(concat(data.aws_route_tables.peer_vpc_rts.ids, list("")))}"
}

output "vpc_peering_id" {
  description = "Peering connection ID"
  value       = "${aws_vpc_peering_connection.this.*.id}"
}

output "vpc_peering_accept_status" {
  description = "Accept status for the connection"
  value       = "${aws_vpc_peering_connection_accepter.peer_accepter.*.accept_status}"
}

output "peer_vpc_id" {
  description = "The ID of the accepter VPC"
  value       = "${aws_vpc_peering_connection_accepter.peer_accepter.*.vpc_id}"
}

output "this_vpc_id" {
  description = "The ID of the requester VPC"
  value       = "${aws_vpc_peering_connection_accepter.peer_accepter.*.peer_vpc_id}"
}

output "this_owner_id" {
  description = "The AWS account ID of the owner of the requester VPC"
  value       = "${aws_vpc_peering_connection_accepter.peer_accepter.*.peer_owner_id}"
}

output "peer_owner_id" {
  description = "The AWS account ID of the owner of the accepter VPC"
  value       = "${var.peer_account_id == "" ? data.aws_caller_identity.this.account_id : var.peer_account_id}"
}

output "peer_region" {
  description = "The region of the accepter VPC"
  value       = "${aws_vpc_peering_connection_accepter.peer_accepter.*.peer_region}"
}

output "accepter_options" {
  description = "VPC Peering Connection options set for the accepter VPC"
  value       = "${aws_vpc_peering_connection_accepter.peer_accepter.*.accepter}"
}

output "requester_options" {
  description = "VPC Peering Connection options set for the requester VPC"
  value       = "${aws_vpc_peering_connection_accepter.peer_accepter.*.requester}"
}

output "this_vpc_route_tables" {
  description = "Private route tables"
  value       = ["${local.this_vpc_route_tables}"]
}

output "peer_vpc_route_table" {
  description = "Public route tables"
  value       = ["${local.peer_vpc_route_tables}"]
}

output "deprecation_notice" {
  description = "This output is used for deprecation notices"
  value       = "WARNING! Variable `create_peering` will be deprecated in the upcoming releases for Terraform 0.11.x"
}

output "deprecation_notice_1" {
  description = "This output is used for deprecation notices"
  value       = "WARNING! Variable `peer_account_id` will be deprecated in the upcoming releases for Terraform 0.11.x"
}
