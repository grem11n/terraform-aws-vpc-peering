// Fixtures
// VPCs
resource "aws_vpc" "this" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name        = "this_vpc_options"
    Environment = "Test"
  }
}

resource "aws_vpc" "peer" {
  cidr_block           = "172.21.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name        = "peer_vpc_options"
    Environment = "Test"
  }
}

// Route Tables
resource "aws_route_table" "this" {
  count  = length(var.this_subnets)
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "This VPC RT"
    Environment = "Test"
  }
}

resource "aws_route_table" "peer" {
  count  = length(var.peer_subnets)
  vpc_id = aws_vpc.peer.id

  tags = {
    Name        = "Peer VPC RT"
    Environment = "Test"
  }
}

// Subnets
resource "aws_subnet" "this" {
  count             = length(var.this_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.this_subnets[count.index]
  availability_zone = element(var.azs, count.index)

  tags = {
    Name        = "This VPC Subnet"
    Environment = "Test"
  }
}

resource "aws_subnet" "peer" {
  count             = length(var.peer_subnets)
  vpc_id            = aws_vpc.peer.id
  cidr_block        = var.peer_subnets[count.index]
  availability_zone = element(var.azs, count.index)

  tags = {
    Name        = "This VPC Subnet"
    Environment = "Test"
  }
}
