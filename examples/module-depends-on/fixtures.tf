// Fixtures
variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    Name        = "this_vpc"
    Environment = "Test"
    TestName    = "ModuleDependsOn"
  }
}
// VPCs
resource "aws_vpc" "this" {
  cidr_block = "172.20.0.0/16"

  tags = var.tags
}

resource "aws_vpc" "peer" {
  cidr_block = "172.21.0.0/16"

  tags = {
    Name        = "peer_vpc"
    Environment = "Test"
  }
}

// Route Tables
resource "aws_route_table" "this" {
  count  = length(var.this_subnets)
  vpc_id = aws_vpc.this.id

  tags = var.tags
}

resource "aws_route_table" "peer" {
  count  = length(var.peer_subnets)
  vpc_id = aws_vpc.peer.id

  tags = var.tags
}

// Subnets
resource "aws_subnet" "this" {
  count             = length(var.this_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.this_subnets[count.index]
  availability_zone = element(var.azs, count.index)

  tags = var.tags
}

resource "aws_subnet" "peer" {
  count             = length(var.peer_subnets)
  vpc_id            = aws_vpc.peer.id
  cidr_block        = var.peer_subnets[count.index]
  availability_zone = element(var.azs, count.index)

  tags = var.tags
}
