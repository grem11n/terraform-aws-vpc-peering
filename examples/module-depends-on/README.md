# Using `depends_on` With This Module

If you're using Terraform `>=0.13`, you [can use `depends_on` meta-argument with modules as well](https://www.terraform.io/docs/language/meta-arguments/depends_on.html)

This example shows you, how to create both VPCs themselves and peering connection using this module and `depends_on` meta-argument.

## Single-apply with newly-created VPCs

Historically this example required running Terraform **twice**: when the VPCs and
route tables are created in the same apply, the module read each VPC's CIDR from
the `aws_vpc` data source by id, which resolves to an apply-time-unknown value.
That unknown propagated into the route `count`/`for_each`, so the first plan
failed with `Invalid count argument` / `Invalid for_each argument`.

You can now plan and apply in a **single pass** by passing the values that the
module would otherwise discover via data sources:

- `this_rts_ids` / `peer_rts_ids` — the route table IDs (known length at plan time)
- `this_vpc_cidr` / `peer_vpc_cidr` — the VPC CIDR blocks (known values at plan time)

When these are supplied, the module skips the apply-time-unknown data-source
reads, so the route resource counts are known at plan time and no second apply
is required.

## Sample Code

Configuration for VPC (subnets, route tables, etc.) is omitted.

Notice, that you have to explicitly provide the Route Table IDs and VPC CIDRs as
variables to this module in order to make it work in a single apply.

```hcl
module "module_depends_on" {
  source = "../../"

  depends_on = [
    aws_route_table.this,
    aws_route_table.peer,
  ]

  providers = {
    aws.this = aws
    aws.peer = aws
  }

  this_vpc_id  = aws_vpc.this.id
  peer_vpc_id  = aws_vpc.peer.id
  this_rts_ids = aws_route_table.this.*.id
  peer_rts_ids = aws_route_table.peer.*.id

  # Keep the CIDRs known at plan time so the whole thing applies in one pass.
  this_vpc_cidr = aws_vpc.this.cidr_block
  peer_vpc_cidr = aws_vpc.peer.cidr_block

  auto_accept_peering = true

  tags = {
    Name        = "tf-single-account-single-region"
    Environment = "Test"
  }
}
```
