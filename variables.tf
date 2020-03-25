variable "peer_vpc_id" {
  description = "Peer VPC ID: string"
  type        = string
  default     = ""
}

variable "this_vpc_id" {
  description = "This VPC ID: string"
  type        = string
  default     = ""
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

variable "peer_dns_resolution" {
  description = "Indicates whether a local VPC can resolve public DNS hostnames to private IP addresses when queried from instances in a peer VPC"
  type        = bool
  default     = false
}

variable "peer_link_to_peer_classic" {
  description = "Indicates whether a local ClassicLink connection can communicate with the peer VPC over the VPC Peering Connection"
  type        = bool
  default     = false
}

variable "peer_link_to_local_classic" {
  description = "Indicates whether a local VPC can communicate with a ClassicLink connection in the peer VPC over the VPC Peering Connection"
  type        = bool
  default     = false
}

variable "this_dns_resolution" {
  description = "Indicates whether a local VPC can resolve public DNS hostnames to private IP addresses when queried from instances in a this VPC"
  type        = bool
  default     = false
}

variable "this_link_to_peer_classic" {
  description = "Indicates whether a local ClassicLink connection can communicate with the this VPC over the VPC Peering Connection"
  type        = bool
  default     = false
}

variable "this_link_to_local_classic" {
  description = "Indicates whether a local VPC can communicate with a ClassicLink connection in the this VPC over the VPC Peering Connection"
  type        = bool
  default     = false
}
