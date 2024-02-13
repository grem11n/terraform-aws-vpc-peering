output "this_vpc_id" {
  value = aws_vpc.this.id
}

output "peer_vpc_id" {
  value = aws_vpc.peer.id
}

output "this_main_route_table" {
  value = data.aws_route_table.this_main_route_table.id
}

output "peer_main_route_table" {
  value = data.aws_route_table.peer_main_route_table.id
}

output "this_subnet_ids" {
  value = aws_subnet.this.*.id
}

output "peer_subnet_ids" {
  value = aws_subnet.peer.*.id
}

output "this_separate_routes_subnet_ids" {
  value = aws_subnet.this_separate_routes.*.id
}

output "peer_separate_routes_subnet_ids" {
  value = aws_subnet.peer_separate_routes.*.id
}

output "this_route_tables" {
  value = aws_route_table.this.*.id
}

output "peer_route_tables" {
  value = aws_route_table.peer.*.id
}
