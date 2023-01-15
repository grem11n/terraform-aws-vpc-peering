// Variables are required to pass them via Terratest
// on fixtures creation
variable "this_vpc_id" {}

variable "peer_vpc_id" {}

variable "aws_this_access_key" {
  description = "AWS Access Key for requester account"
}

variable "aws_this_secret_key" {
  description = "AWS Secret Key for requester account"
}
