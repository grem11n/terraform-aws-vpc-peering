AWS VPC Peering Connection Module
=================================

Terraform module, which creates a peering connection between two VPCs and adds routes to the local VPC.
Routes on the Peer VPC side should be configured separately.

This module is designed to work with [VPC](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/) module from the Terraform Registry

Important Notice
----

HashiCorp has [anounced the deprecation of Terraform 0.11 support in Terraform providers](https://www.hashicorp.com/blog/deprecating-terraform-0-11-support-in-terraform-providers/).

What does it mean for this module? I won't do any active development for the `terraform011` branch. However, PRs are still welcome.

In any case, this module is pretty much mature and covers all the functionality related to the VPC peering. Hence, it's Ok to use versions for Terraform 0.11, but I strongly suggest you to upgrade.

Preamble
----
**Always make sure you pinned the module version!**
Please, be aware that any new code in `master` may intorduce some regressions. Moreover, sometimes I can easily miss some of them because I personally doen't use all the VPC peering features on daily basis.

Terraform versions / Contributions
----

Terraform 0.12. Pin module version to `~> v2.0`. Submit pull-requests to `master` branch.

Terraform 0.11. Pin module version to `~> v1.0`. Submit pull-requests to `terraform011` branch.

Changelog
----
Changelog is in the [CHANGELOG.md](CHANGELOG.md)


Note
----

These types of resources are supported:

* [Peering Connection](https://www.terraform.io/docs/providers/aws/d/vpc_peering_connection.html)
* [AWS Route](https://www.terraform.io/docs/providers/aws/r/route.html)
* [AWS VPC Peering Connection Accepter](https://www.terraform.io/docs/providers/aws/r/vpc_peering_accepter.html)
* [AWS VPC Peering Connection Options](https://www.terraform.io/docs/providers/aws/r/vpc_peering_options.html)

Usage
-----

### Examples
Sample configuration is located in [examples](examples/) directory.

### Single Region Peering
**Notice**: You need to declare both providers even with single region peering.

```
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

Usage with already created peering connection:
```hc1
module "vpc_single_region_peering" {
  source = "./terraform-aws-vpc-peering"

  providers = {
    aws.this = aws
    aws.peer = aws
  }

  peer_region             = "eu-west-1"
  this_vpc_id             = "vpc-00000000"
  peer_vpc_id             = "vpc-11111111"
  cross_region_peering    = false
  auto_accept_peering     = true
  peering_id              = "pcx-00000000"

}
```

### Cross Region Peering / Cross Account Peering

In order to setup cross-region or cross-account peering connection, you must configure `providers` for Terraform. You can find an example [here](examples/multi-account-multi-region).

[Medium post](https://medium.com/@bonya/terraform-managing-resources-in-multiple-aws-accounts-c13015b89fce), which might be useful.

```hc1
module "vpc_cross_region_peering" {
  source = "github.com/grem11n/terraform-aws-vpc-peering?ref=cross-region-peering"

  providers = {
    aws.this = aws.src
    aws.peer = aws.dst
  }

  peer_region             = "us-east-1"
  this_vpc_id             = "vpc-00000000"
  peer_vpc_id             = "vpc-11111111"
  cross_region_peering    = true
  auto_accept_peering     = true

  tags = {
    Name        = "my-peering-connection"
    Environment = "prod"
  }
}
```

Testing
----

This module is tested with [Terratest](https://github.com/gruntwork-io/terratest)
You can find existing tests in the [test/](test/) directory.

Authors
-------
Module managed by [Yurii Rochniak](https://github.com/grem11n)

License
-------
Apache 2 Licensed. See LICENSE for full details.
