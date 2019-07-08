variable "peer_account_id" {
  description = "AWS owner account ID for Peer VPC. Default to the current account: string"
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

variable "peer_dns_resolution" {
  description = "Indicates whether a local VPC can resolve public DNS hostnames to private IP addresses when queried from instances in a peer VPC"
  default     = false
}

variable "peer_link_to_peer_classic" {
  description = "Indicates whether a local ClassicLink connection can communicate with the peer VPC over the VPC Peering Connection"
  default     = false
}

variable "peer_link_to_local_classic" {
  description = "Indicates whether a local VPC can communicate with a ClassicLink connection in the peer VPC over the VPC Peering Connection"
  default     = false
}

variable "this_dns_resolution" {
  description = "Indicates whether a local VPC can resolve public DNS hostnames to private IP addresses when queried from instances in a this VPC"
  default     = false
}

variable "this_link_to_peer_classic" {
  description = "Indicates whether a local ClassicLink connection can communicate with the this VPC over the VPC Peering Connection"
  default     = false
}

variable "this_link_to_local_classic" {
  description = "Indicates whether a local VPC can communicate with a ClassicLink connection in the this VPC over the VPC Peering Connection"
  default     = false
}
