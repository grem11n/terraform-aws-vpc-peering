// Variables
variable "aws_this_access_key" {
  description = "AWS Access Key for requester account"
}

variable "aws_this_secret_key" {
  description = "AWS Secret Key for requester account"
}

variable "this_cidr" {
  description = "CIDR for this VPC"
  default     = "172.20.0.0/16"
}

variable "peer_cidr" {
  description = "CIDR for peer VPC"
  default     = "172.21.0.0/16"
}

variable "this_subnets" {
  description = "Subnet list for _this_ VPC"
  type        = list(string)
  default     = ["172.20.0.0/24", "172.20.1.0/24", "172.20.2.0/24"]
}

variable "peer_subnets" {
  description = "Subnet list for _peer_ VPC"
  type        = list(string)
  default     = ["172.21.0.0/24", "172.21.1.0/24", "172.21.2.0/24"]
}

variable "this_associated_cidr" {
  description = "Associated (additional) CIDR for this VPC"
  default     = "172.22.0.0/16"
}

variable "this_associated_subnets" {
  description = "Subnet list for _this_ VPC"
  type        = list(string)
  default     = ["172.22.0.0/24", "172.22.1.0/24", "172.22.2.0/24"]
}

variable "peer_associated_subnets" {
  description = "Subnet list for _peer_ VPC"
  type        = list(string)
  default     = ["172.23.0.0/24", "172.23.1.0/24", "172.23.2.0/24"]
}

variable "peer_associated_cidr" {
  description = "Associated (additional) CIDR for peer VPC"
  default     = "172.23.0.0/16"
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}
