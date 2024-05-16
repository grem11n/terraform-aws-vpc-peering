// Fixtures
// VPC
resource "aws_vpc" "this" {
  provider             = aws.this
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name        = "this_vpc"
    Environment = "Test"
  }
}

resource "aws_vpc" "peer" {
  provider             = aws.peer
  cidr_block           = "172.21.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name        = "peer_vpc"
    Environment = "Test"
  }
}

// Route Tables
resource "aws_route_table" "this" {
  provider = aws.this
  count    = length(var.this_subnets)
  vpc_id   = aws_vpc.this.id

  tags = {
    Name        = "This VPC RT"
    Environment = "Test"
  }
}

resource "aws_route_table" "peer" {
  provider = aws.peer
  count    = length(var.peer_subnets)
  vpc_id   = aws_vpc.peer.id

  tags = {
    Name        = "Peer VPC RT"
    Environment = "Test"
  }
}

// Subnets

// on main route table
resource "aws_subnet" "this" {
  provider          = aws.this
  count             = length(var.azs_this)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.this_subnets[count.index]
  availability_zone = element(var.azs_this, count.index)

  tags = {
    Name        = "This VPC Subnet"
    Environment = "Test"
  }
}

// on separate route tables
resource "aws_subnet" "this_separate_routes" {
  provider          = aws.this
  count             = length(var.azs_this)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.this_subnets_separate_routes[count.index]
  availability_zone = element(var.azs_this, count.index)

  tags = {
    Name        = "This VPC Subnet with separate routes"
    Environment = "Test"
  }
}

resource "aws_route_table_association" "this" {
  provider       = aws.this
  count          = length(var.azs_this)
  subnet_id      = aws_subnet.this_separate_routes[count.index].id
  route_table_id = aws_route_table.this[count.index].id
}

resource "aws_subnet" "peer" {
  provider          = aws.peer
  count             = length(var.azs_peer)
  vpc_id            = aws_vpc.peer.id
  cidr_block        = var.peer_subnets[count.index]
  availability_zone = element(var.azs_peer, count.index)

  tags = {
    Name        = "This VPC Subnet"
    Environment = "Test"
  }
}

resource "aws_subnet" "peer_separate_routes" {
  provider          = aws.peer
  count             = length(var.azs_peer)
  vpc_id            = aws_vpc.peer.id
  cidr_block        = var.peer_subnets_separate_routes[count.index]
  availability_zone = element(var.azs_peer, count.index)

  tags = {
    Name        = "This VPC Subnet with separate routes"
    Environment = "Test"
  }
}

resource "aws_route_table_association" "peer" {
  provider       = aws.peer
  count          = length(var.azs_peer)
  subnet_id      = aws_subnet.peer_separate_routes[count.index].id
  route_table_id = aws_route_table.peer[count.index].id
}