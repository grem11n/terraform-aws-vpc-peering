provider "aws" {
  alias      = "this"
  region     = "eu-west-1"
  access_key = var.aws_this_access_key
  secret_key = var.aws_this_secret_key
}

provider "aws" {
  alias      = "peer"
  region     = "eu-west-2"
  access_key = var.aws_this_access_key
  secret_key = var.aws_this_secret_key
}
