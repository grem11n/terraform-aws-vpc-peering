// Creates a peering between VPCs different accounts and different regions
module "multi_account_multi_region" {
  source = "../../"

  providers = {
    aws.this = aws.this
    aws.peer = aws.peer
  }

  this_region = "us-east-1"
  peer_region = "us-west-1"

  this_vpc_id = var.this_vpc_id
  peer_vpc_id = var.peer_vpc_id

  auto_accept_peering = true

  tags = {
    Name        = "tf-multi-account-multi-region"
    Environment = "Test"
  }
}
