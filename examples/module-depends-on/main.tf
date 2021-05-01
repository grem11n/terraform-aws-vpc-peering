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

  auto_accept_peering = true

  tags = {
    Name        = "tf-module-depends-on"
    Environment = "Test"
  }
}
