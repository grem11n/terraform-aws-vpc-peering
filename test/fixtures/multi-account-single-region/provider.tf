provider "aws" {
  alias      = "this"
  region     = "ap-southeast-2"
  access_key = var.aws_this_access_key
  secret_key = var.aws_this_secret_key
}

provider "aws" {
  alias      = "peer"
  region     = "ap-southeast-2"
  access_key = var.aws_peer_access_key
  secret_key = var.aws_peer_secret_key
}
