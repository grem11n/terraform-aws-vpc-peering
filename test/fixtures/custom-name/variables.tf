variable "this_subnets" {
  description = "Subnet list for _this_ VPC"
  type        = list(string)
  default     = ["172.22.0.0/24", "172.22.1.0/24", "172.22.2.0/24"]
}

variable "peer_subnets" {
  description = "Subnet list for _peer_ VPC"
  type        = list(string)
  default     = ["172.23.0.0/24", "172.23.1.0/24", "172.23.2.0/24"]
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}
