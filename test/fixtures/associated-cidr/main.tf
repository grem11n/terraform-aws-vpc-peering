module "this_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                  = "this-vpc"
  cidr                  = "10.0.0.0/16"
  secondary_cidr_blocks = ["10.10.0.0/16"]

  azs = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  intra_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.10.1.0/24",
    "10.10.2.0/24",
    "10.10.3.0/24",
  ]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Name        = "this-vpc"
    Terraform   = "true"
    Environment = "Test"
  }
}

module "peer_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                  = "peer-vpc"
  cidr                  = "10.1.0.0/16"
  secondary_cidr_blocks = ["10.11.0.0/16"]

  azs = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  intra_subnets = [
    "10.1.1.0/24",
    "10.1.2.0/24",
    "10.1.3.0/24",
    "10.11.1.0/24",
    "10.11.2.0/24",
    "10.11.3.0/24",
  ]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Name        = "peer-vpc"
    Terraform   = "true"
    Environment = "Test"
  }
}
