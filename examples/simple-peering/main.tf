provider "aws" {
  region = "us-east-1"
}

module "peering" {
  source = "../../"

  providers = {
    aws.this = "aws"
    aws.peer = "aws"
  }

  peer_region         = "us-east-1"
  this_vpc_id         = "vpc-00000000000000000"
  peer_vpc_id         = "vpc-11111111111111111"
  create_peering      = true
  auto_accept_peering = true

  tags = {
    Name        = "tf-example-peering"
    Environment = "test"
  }
}
