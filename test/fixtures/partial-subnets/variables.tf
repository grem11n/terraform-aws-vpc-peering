variable "this_subnets" {
  description = "Subnet list for _this_ VPC"
  type        = list(string)
  default     = ["172.20.0.0/24", "172.20.1.0/24", "172.20.2.0/24"]
}

variable "this_subnets_separate_routes" {
  description = "Subnet list for _this_ VPC"
  type        = list(string)
  default     = ["172.20.10.0/24", "172.20.11.0/24", "172.20.12.0/24"]
}

variable "peer_subnets" {
  description = "Subnet list for _peer_ VPC"
  type        = list(string)
  default     = ["172.21.0.0/24", "172.21.1.0/24", "172.21.2.0/24"]
}

variable "peer_subnets_separate_routes" {
  description = "Subnet list for _peer_ VPC"
  type        = list(string)
  default     = ["172.21.10.0/24", "172.21.11.0/24", "172.21.12.0/24"]
}

variable "azs_this" {
  description = "Availability Zones for requester VPC"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}

variable "azs_peer" {
  description = "Availability Zones for accepter VPC"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}
