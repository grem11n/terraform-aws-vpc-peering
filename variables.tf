variable "owner_account_id" {
  description = "AWS owner account ID"
  default     = ""
}

variable "vpc_peer_id" {
  description = "Peer VPC ID"
  default     = ""
}

variable "this_vpc_id" {
  description = "This VPC ID"
  default     = ""
}

variable "private_route_table_ids" {
  type        = "list"
  description = "A list of private route tables"
  default     = []
}

variable "public_route_table_ids" {
  type        = "list"
  description = "A list of public route tables"
  default     = []
}

variable "peer_cird_block" {
  description = "Peer VPC CIDR block"
  default     = ""
}

variable "auto_accept_peering" {
  description = "Auto accept peering connection"
  default     = false
}
