provider "aws" {
  alias = "this"
  region = var.this_region != "" ? var.this_region : "eu-west-2"
  assume_role {
    role_arn     = var.this_assume_role_arn != "" ? var.this_assume_role_arn : null     
  }
  access_key = var.aws_this_access_key != "" ? var.aws_this_access_key : null
  secret_key = var.aws_this_secret_key != "" ? var.aws_this_secret_key : null
}

provider "aws" {
  alias = "peer"
  region = var.peer_region != "" ? var.peer_region : "eu-central-1"
  assume_role {
    role_arn     = var.peer_assume_role_arn != "" ? var.peer_assume_role_arn : null
  }
  access_key = var.aws_peer_access_key != "" ? var.aws_peer_access_key : null
  secret_key = var.aws_peer_secret_key != "" ? var.aws_peer_secret_key : null
}

