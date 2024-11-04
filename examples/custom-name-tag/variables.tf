// Variables are required to pass them via Terratest
// on fixtures creation
variable "this_vpc_id" {
  type = string
}

variable "peer_vpc_id" {
  type = string
}

variable "name" {
  description = "Name of the VPC Peering Connection"
  default     = ""
  type        = string
}
