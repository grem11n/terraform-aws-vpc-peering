output "this_vpc_id" {
  value = aws_vpc.this.id
}

output "peer_vpc_id" {
  value = aws_vpc.peer.id
}
