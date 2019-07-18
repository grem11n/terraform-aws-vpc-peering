// Variables
variable "this_subnets" {
  description = "Subnet list for _this_ VPC"
  type        = "list"
  default     = ["172.20.0.0/24", "172.20.1.0/24", "172.20.2.0/24"]
}

variable "peer_subnets" {
  description = "Subnet list for _peer_ VPC"
  type        = "list"
  default     = ["172.21.0.0/24", "172.21.1.0/24", "172.21.2.0/24"]
}

variable "azs" {
  description = "Availability Zones"
  type        = "list"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
