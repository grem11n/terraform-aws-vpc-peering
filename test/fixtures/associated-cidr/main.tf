// Fixtures
// VPCs
resource "aws_vpc" "this" {
  cidr_block = var.this_cidr

  tags = {
    Name        = "this_vpc"
    Environment = "Test"
  }
}

resource "aws_vpc" "peer" {
  cidr_block = var.peer_cidr

  tags = {
    Name        = "peer_vpc"
    Environment = "Test"
  }
}

// Associated (additional) CIDRs for VPCs
resource "aws_vpc_ipv4_cidr_block_association" "this_associated_cidr" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.this_associated_cidr
}

resource "aws_vpc_ipv4_cidr_block_association" "peer_associated_cidr" {
  vpc_id     = aws_vpc.peer.id
  cidr_block = var.peer_associated_cidr
}

// Route Tables
resource "aws_route_table" "this" {
  count  = length(concat(var.this_subnets, var.this_associated_subnets))
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "This VPC RT"
    Environment = "Test"
  }
}

resource "aws_route_table" "peer" {
  count  = length(concat(var.peer_subnets, var.peer_associated_subnets))
  vpc_id = aws_vpc.peer.id

  tags = {
    Name        = "Peer VPC RT"
    Environment = "Test"
  }
}

// Subnets
resource "aws_subnet" "this" {
  count             = length(concat(var.this_subnets, var.this_associated_subnets))
  vpc_id            = aws_vpc.this.id
  cidr_block        = element(concat(var.this_subnets, var.this_associated_subnets), count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name        = "This VPC Subnet"
    Environment = "Test"
  }
}

resource "aws_subnet" "peer" {
  count             = length(concat(var.peer_subnets, var.peer_associated_subnets))
  vpc_id            = aws_vpc.peer.id
  cidr_block        = element(concat(var.peer_subnets, var.peer_associated_subnets), count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name        = "This VPC Subnet"
    Environment = "Test"
  }
}
