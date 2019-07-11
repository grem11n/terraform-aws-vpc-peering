// Required for tests
output "vpc_peering_accept_status" {
  value = "${module.single_account_single_region_options.vpc_peering_accept_status}"
}

output "accepter_options" {
  value = "${module.single_account_single_region_options.accepter_options}"
}

output "requester_options" {
  value = "${module.single_account_single_region_options.requester_options}"
}
