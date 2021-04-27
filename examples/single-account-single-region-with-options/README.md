# Single Account Single Region Peering Connection with Peering Options

**Important Notice**: Currently, you need to run `apply` twice to configure the peering options initially.

Configuration in this directory creates a peering connection between VPCs in a single region within the same AWS account. It also creates connection options:

* Cross-VPC DNS resolution option
* Allow classic link access between VPCs

## Code Sample

```
provider "aws" {
  region     = "us-east-2"
}

module "single_account_single_region_options" {
  source = "../../"

  providers = {
    aws.this = aws
    aws.peer = aws
  }

  this_vpc_id = var.this_vpc_id
  peer_vpc_id = var.peer_vpc_id

  auto_accept_peering = true

  // Peering options for requester
  this_dns_resolution        = true
  this_link_to_peer_classic  = true
  this_link_to_local_classic = true

  // Peering options for accepter
  peer_dns_resolution        = true
  peer_link_to_peer_classic  = true
  peer_link_to_local_classic = true

  tags = {
    Name        = "tf-single-account-single-region-with-options"
    Environment = "Test"
  }
}
```

## Usage

Modify the variables to suite your purposes. Then run:

```bash
terraform init
terraform plan
terraform apply
```
