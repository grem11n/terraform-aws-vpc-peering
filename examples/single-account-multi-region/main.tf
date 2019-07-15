// Creates a peering between VPCs in the same account, but different regions
module "single_account_multi_region" {
  source = "../../"

  providers = {
    aws.this = "aws.us-east-1"
    aws.peer = "aws.us-west-1"
  }

  this_vpc_id = "${var.this_vpc_id}"
  peer_vpc_id = "${var.peer_vpc_id}"

  peer_region = "us-west-1"

  create_peering      = true
  auto_accept_peering = true

  tags = {
    Name        = "tf-single-account-multi-region"
    Environment = "Test"
  }
}
