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

variable "azs_this" {
  description = "Availability Zones for requester VPC"
  type        = "list"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "azs_peer" {
  description = "Availability Zones for accepter VPC"
  type        = "list"
  default     = ["us-west-1a", "us-west-1b"]
}
