// Single Account single region example
// Additional options are created
module "single_account_single_region_options" {
  source = "../../"

  providers = {
    aws.this = aws
    aws.peer = aws
  }

  this_vpc_id = var.this_vpc_id
  peer_vpc_id = var.peer_vpc_id

  auto_accept_peering = true

  // Peering options for requester
  this_dns_resolution        = true

  // Peering options for accepter
  peer_dns_resolution        = true

  tags = {
    Name        = "tf-single-account-single-region-with-options"
    Environment = "Test"
  }
}
