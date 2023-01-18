# Creating Routes for Additional CIDR Blocks

This is an example of how to create routes for the [additional CIDR blocks of a VPC](https://docs.aws.amazon.com/vpc/latest/userguide/configure-your-vpc.html#vpc-cidr-blocks).

There are specific additional variables that a user has to turn on in order to enable these routes:

- `from_this_associated`
- `from_peer_associated`

The reason is that if creating both VPCs and peerings in a single go, Terraform won't be able to calculate associated CIDR blocks.
See [this discussion comment](https://github.com/hashicorp/terraform/issues/28962#issuecomment-861596870).
Therefore, it may be impossible to create routes for additional CIDR blocks in one Terraform go in the combination with `depends_on` directive.
If this is your case, several Terraform runs may be required.

## Sample Code

```hcl
provider "aws" {
  region     = "eu-west-1"
  access_key = var.aws_this_access_key
  secret_key = var.aws_this_secret_key
}

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
```
