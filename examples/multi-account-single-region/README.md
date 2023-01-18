# Cross Account Single Region VPC Peering

This example creates a peering connection between VPCs in a single region which are located in different AWS accounts.
See [provider.tf](provider.tf) for details.

## Sample Code

```hcl
module "multi_account_single_region" {
  source = "../../"

  providers = {
    aws.this = aws.this
    aws.peer = aws.peer
  }

  this_vpc_id = var.this_vpc_id
  peer_vpc_id = var.peer_vpc_id

  auto_accept_peering = true

  tags = {
    Name        = "tf-multi-account-single-region"
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
