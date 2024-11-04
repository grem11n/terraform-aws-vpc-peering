// Required for tests
output "vpc_peering_accept_status" {
  value = module.custiom_name.vpc_peering_accept_status
}

output "vpc_peering_connection" {
  value = module.custiom_name.aws_vpc_peering_connection
}
