output "vpc_peering_id" {
  description = "Peering connection ID"
  value       = "${module.peering.vpc_peering_id}"
}

output "vpc_peering_accept_status" {
  description = "Accept status for the connection"
  value       = "${module.peering.vpc_peering_accept_status}"
}

output "peer_vpc_id" {
  description = "The ID of the accepter VPC"
  value       = "${module.peering.peer_vpc_id}"
}

output "this_vpc_id" {
  description = "The ID of the requester VPC"
  value       = "${module.peering.this_vpc_id}"
}

output "this_owner_id" {
  description = "The AWS account ID of the owner of the requester VPC"
  value       = "${module.peering.this_owner_id}"
}

output "peer_owner_id" {
  description = "The AWS account ID of the owner of the accepter VPC"
  value       = "${module.peering.peer_owner_id}"
}

output "peer_region" {
  description = "The region of the accepter VPC"
  value       = "${module.peering.peer_region}"
}

output "accepter_options" {
  description = "VPC Peering Connection options set for the accepter VPC"
  value       = "${module.peering.accepter_options}"
}

output "requester_options" {
  description = "VPC Peering Connection options set for the requester VPC"
  value       = "${module.peering.requester_options}"
}

output "this_vpc_route_tables" {
  description = "Private route tables"
  value       = "${module.peering.this_vpc_route_tables}"
}

output "peer_vpc_route_table" {
  description = "Public route tables"
  value       = "${module.peering.peer_vpc_route_table}"
}
