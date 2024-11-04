// Basic Module Example
// Creates a peering between VPCs in the same account in the same region
module "custom_name" {
  source = "../../"

  providers = {
    aws.this = aws
    aws.peer = aws
  }

  // Required for tests
  name = var.name

  this_vpc_id = var.this_vpc_id
  peer_vpc_id = var.peer_vpc_id

  auto_accept_peering = true

  tags = {
    Name        = "tf-single-account-single-region"
    Environment = "Test"
  }
}
