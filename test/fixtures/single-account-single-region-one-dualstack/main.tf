// Fixtures
// VPC
resource "aws_vpc" "this" {
  cidr_block                       = "172.20.0.0/16"
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name        = "this_vpc"
    Environment = "Test"
  }
}

resource "aws_vpc" "peer" {
  cidr_block                       = "172.21.0.0/16"
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name        = "peer_vpc"
    Environment = "Test"
  }
}

// Route Tables
resource "aws_route_table" "this" {
  count    = length(var.azs)

  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "This VPC RT"
    Environment = "Test"
  }
}

resource "aws_route_table" "peer" {
  count    = length(var.azs)

  vpc_id = aws_vpc.peer.id

  tags = {
    Name        = "Peer VPC RT"
    Environment = "Test"
  }
}

// Subnets
resource "aws_subnet" "this" {
  for_each = toset(var.azs)

  vpc_id     = aws_vpc.this.id
  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 5, index(var.azs, each.value))
  // IPV6 Subnet cidr needs to align to /64, aws provides a /56 CIDR automatically
  ipv6_cidr_block   = cidrsubnet(aws_vpc.this.ipv6_cidr_block, 8, index(var.azs, each.value))
  availability_zone = each.value

  tags = {
    Name        = "This VPC Subnet"
    Environment = "Test"
  }
}

resource "aws_subnet" "peer" {
  for_each = toset(var.azs)

  vpc_id     = aws_vpc.peer.id
  cidr_block = cidrsubnet(aws_vpc.peer.cidr_block, 5, index(var.azs, each.value))
  availability_zone = each.value

  tags = {
    Name        = "This VPC Subnet"
    Environment = "Test"
  }
}
