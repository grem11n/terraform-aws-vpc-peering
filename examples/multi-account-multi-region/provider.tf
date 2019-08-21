provider "aws" {
  alias      = "this"
  region     = "us-east-1"
  access_key = var.aws_this_access_key
  secret_key = var.aws_this_secret_key
}

provider "aws" {
  alias      = "peer"
  region     = "us-west-1"
  access_key = var.aws_peer_access_key
  secret_key = var.aws_peer_secret_key
}

# # if you have ~/.aws/credentials as below
# [this_account]
# region                = ap-southeast-2
# aws_secret_access_key = xxxx
# aws_access_key_id     = xxxx
#
# [peer_account]
# region                = ap-southeast-2
# aws_secret_access_key = xxxx
# aws_access_key_id     = xxxx
#
# you can adjust to
#
# provider "aws" {
#   alias      = "this"
#   region     = "us-east-1"
#   profile    = "this_account"
# }
#
# provider "aws" {
#   alias      = "peer"
#   region     = "us-west-1"
#   profile    = "peer_account"
# }
