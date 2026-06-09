// Basic Module Example
// Creates a peering between VPCs in the same account in the same region
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

  # Pass the CIDRs explicitly so they stay known at plan time. Combined with the
  # explicit *_rts_ids above, this lets the module plan in a SINGLE apply even
  # though the VPCs and route tables are created in the same run -- no need to
  # run Terraform twice.
  this_vpc_cidr = aws_vpc.this.cidr_block
  peer_vpc_cidr = aws_vpc.peer.cidr_block

  auto_accept_peering = true

  tags = {
    Name        = "tf-module-depends-on"
    Environment = "Test"
  }
}
