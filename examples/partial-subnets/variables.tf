variable this_assume_role_arn {
  type = string
  default = ""
}

variable peer_assume_role_arn {
  type = string
  default = ""
}

variable "aws_this_access_key" {
  description = "AWS Access Key for requester account"
  default = ""
}

variable "aws_this_secret_key" {
  description = "AWS Secret Key for requester account"
  default = ""
}

variable "aws_peer_access_key" {
  description = "AWS Access Key for accepter account"
  default = ""
}

variable "aws_peer_secret_key" {
  description = "AWS Secret Key for accepter account"
  default = ""
}


variable this_region {
  type = string
  default = "eu-central-1"
}

variable peer_region {
  type = string
  default = "eu-central-1"
}

variable this_vpc_id {
  type = string  
}

variable peer_vpc_id {
  type = string     
}

variable "auto_accept_peering" {
  description = "Auto accept peering connection: bool"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags: map"
  type        = map(string)
  default     = {}
}

variable "peer_subnets_ids" {
  description = "If communication can only go to some specific subnets of peer vpc. If empty whole vpc cidr is allowed"
  type        = list(string)
  default     = []
}

variable "this_subnets_ids" {
  description = "If communication can only go to some specific subnets of this vpc. If empty whole vpc cidr is allowed"
  type        = list(string)
  default     = []
}

variable "this_rts_ids" {
  description = "Allows to explicitly specify route tables for this VPC"
  type        = list(string)
  default     = []
}

variable "peer_rts_ids" {
  description = "Allows to explicitly specify route tables for peer VPC"
  type        = list(string)
  default     = []
}