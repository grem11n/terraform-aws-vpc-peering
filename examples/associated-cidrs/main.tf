// Basic Module Example
// Creates a peering between VPCs in the same account in the same region
module "associated_cidrs" {
  source = "../../"

  providers = {
    aws.this = aws
    aws.peer = aws
  }

  this_vpc_id = var.this_vpc_id
  peer_vpc_id = var.peer_vpc_id

  from_this_associated = true
  from_peer_associated = true

  auto_accept_peering = true

  tags = {
    Name        = "tf-associated-cirds"
    Environment = "Test"
  }
}
