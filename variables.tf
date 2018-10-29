variable "owner_account_id" {
  description = "AWS owner account ID: string"
  default     = ""
}

variable "peer_vpc_id" {
  description = "Peer VPC ID: string"
  default     = ""
}

variable "this_vpc_id" {
  description = "This VPC ID: string"
  default     = ""
}

variable "cross_region_peering" {
  description = "Is it a cross region peering: bool"
  default     = false
}

variable "peer_region" {
  description = "Peer Region Name e.g. us-east-1: string"
  default     = ""
}

variable "auto_accept_peering" {
  description = "Auto accept peering connection: bool"
  default     = false
}

variable "create_peering" {
  description = "Create peering connection, 0 to not create: bool"
  default     = true
}

variable "peering_id" {
  description = "Provide already existing peering connection id"
  default     = ""
}

variable "tags" {
  description = "Tags: map"
  type        = "map"
  default     = {}
}
