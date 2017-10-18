AWS VPC Peering Connection Module
=================================

Terraform module, which creates a peering connectiob between two VPCs and adds routes to the local VPC.
Routes on the Peer VPC side should be configured separately.

This module is designed to work with [VPC](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/) module from the Terraform Registry

Note
----
Some features of the `aws_peering_conection` resource are missing. However, they can be easily added on request

These types of resources are supported:

* [Perring Connection](https://www.terraform.io/docs/providers/aws/d/vpc_peering_connection.html)
* [AWS Route](https://www.terraform.io/docs/providers/aws/r/route.html)

Usage
-----
Sample usage in cobination with [VPC](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/) Terraform module:

```hc1
module "vpc-peering" {
  source = "./terraform-aws-vpc-peering"

  owner_account_id        = "000000000000"
  vpc_peer_id             = "vpc-00000000"
  this_vpc_id             = "${module.vpc.vpc_id}"
  private_route_table_ids = ["${module.vpc.private_route_table_ids}"]
  public_route_table_ids  = ["${module.vpc.public_route_table_ids}"]
  peer_cird_block         = "10.1.0.1/24"
  auto_accept_peering     = true
}
```
Examples
--------
Complete example is shown abowe

Authors
-------
Module managed by [Yurii Rochniak](https://github.com/grem11n)

License
-------
Apache 2 Licensed. See LICENSE for full details.