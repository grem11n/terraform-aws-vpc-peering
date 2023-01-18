# Using depends_on With This Module

If you're using Terraform `>=0.13`, you [can use `depedns_on` meta-argument with modules as well](https://www.terraform.io/docs/language/meta-arguments/depends_on.html)

This example shows you, how to create both VPCs themselves and peering connection using this module and `depends_on` meta-argument.

## Sample Code

Configuration for VPC (subnets, route tables, etc.) is omitted.

Notice, that you have to explicitly provide Route Tables IDs as variables to this module in order to make it work.

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

  auto_accept_peering = true

  tags = {
    Name        = "tf-single-account-single-region"
    Environment = "Test"
  }
}
```
