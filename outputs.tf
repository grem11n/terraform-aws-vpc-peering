output "aws_vpc_peering_connection" {
  value = aws_vpc_peering_connection.this
}

output "aws_vpc_peering_connection_accepter" {
  value = aws_vpc_peering_connection_accepter.peer_accepter
}

output "vpc_peering_id" {
  description = "Peering connection ID"
  value       = aws_vpc_peering_connection.this.id
}

output "vpc_peering_accept_status" {
  description = "Accept status for the connection"
  value       = aws_vpc_peering_connection_accepter.peer_accepter.accept_status
}

output "peer_vpc_id" {
  description = "The ID of the accepter VPC"
  value       = aws_vpc_peering_connection_accepter.peer_accepter.vpc_id
}

output "this_vpc_id" {
  description = "The ID of the requester VPC"
  value       = aws_vpc_peering_connection_accepter.peer_accepter.peer_vpc_id
}

output "this_owner_id" {
  description = "The AWS account ID of the owner of the requester VPC"
  value       = aws_vpc_peering_connection_accepter.peer_accepter.peer_owner_id
}

output "peer_owner_id" {
  description = "The AWS account ID of the owner of the accepter VPC"
  value       = data.aws_caller_identity.peer.account_id
}

output "peer_region" {
  description = "The region of the accepter VPC"
  value       = aws_vpc_peering_connection_accepter.peer_accepter.peer_region
}

output "accepter_options" {
  description = "VPC Peering Connection options set for the accepter VPC"
  value       = aws_vpc_peering_connection_accepter.peer_accepter.accepter
}

output "requester_options" {
  description = "VPC Peering Connection options set for the requester VPC"
  value       = aws_vpc_peering_connection_accepter.peer_accepter.requester
}

output "requester_routes" {
  description = "The possible routes and subnets from the requester VPC"
  value       = tolist(aws_route.this_routes_requester.*)
}

output "accepter_routes" {
  description = "The possible routes and subnets to the accepter VPC"
  value = tolist(aws_route.peer_routes_accepter.*)
}
