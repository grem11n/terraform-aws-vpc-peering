# Single Account Multi Region VPC Peering

This example creates a peering connection between VPCs in different regions, which are located in the same AWS account.

## Sample Code

```hcl
provider "aws" {
  alias      = "this"
  region     = "eu-west-1"
}

provider "aws" {
  alias      = "peer"
  region     = "eu-central-1"
}

module "single_account_multi_region" {
  source = "../../"

  providers = {
    aws.this = aws.this
    aws.peer = aws.peer
  }

  this_vpc_id = var.this_vpc_id
  peer_vpc_id = var.peer_vpc_id

  auto_accept_peering = true

  tags = {
    Name        = "tf-single-account-multi-region"
    Environment = "Test"
  }
}
```

## Usage

Change the variables to fit your purposes and run:

```bash
terraform init
terraform plan
terraform apply
```
