data "aws_route_table" "peer_main_route_table" {
  provider = aws.peer
  vpc_id   = aws_vpc.peer.id
  filter {
    name   = "association.main"
    values = ["true"]
  }
}

data "aws_route_table" "this_main_route_table" {
  provider = aws.this
  vpc_id   = aws_vpc.this.id
  filter {
    name   = "association.main"
    values = ["true"]
  }
}