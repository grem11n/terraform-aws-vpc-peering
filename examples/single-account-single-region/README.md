# Single Account Single Region VPC Peering

This is a basic configuration example, which creates a peering connection between VPCs in a single region within the same AWS account.

**Notice**: You need to declare both providers even with single region peering.

## Code Sample

```hcl
provider "aws" {
  region     = "eu-west-1"
}

module "single_account_single_region" {
  source = "../../"

  providers = {
    aws.this = aws
    aws.peer = aws
  }

  this_vpc_id = var.this_vpc_id
  peer_vpc_id = var.peer_vpc_id

  auto_accept_peering = true

  tags = {
    Name        = "tf-single-account-single-region"
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
