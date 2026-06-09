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

variable "name" {
  description = "Name of the peering connection: string"
  type        = string
  default     = ""
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

variable "this_dns_resolution" {
  description = "Indicates whether a local VPC can resolve public DNS hostnames to private IP addresses when queried from instances in a this VPC"
  type        = bool
  default     = false
}

variable "from_this" {
  description = "If traffic TO peer vpc (from this) should be allowed"
  type        = bool
  default     = true
}

variable "from_this_associated" {
  description = "If traffic for associated CIDRs TO peer VPC (from this) should be allowed"
  type        = bool
  default     = false
}

variable "from_peer" {
  description = "If traffic FROM the peer VPC (to this) should be allowed"
  type        = bool
  default     = true
}

variable "from_peer_associated" {
  description = "If traffic FROM associated CIDRs of the peer VPC (to this) should be allowed"
  type        = bool
  default     = false
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

variable "this_vpc_cidr" {
  description = "Explicit IPv4 CIDR block of this VPC. When set, the module uses this value instead of reading it from the aws_vpc data source. Provide it (alongside this_rts_ids) when this VPC is created in the same apply as the peering, so the plan does not depend on apply-time-unknown attributes. If empty, the CIDR is read from the data source (default behavior)."
  type        = string
  default     = ""
}

variable "peer_vpc_cidr" {
  description = "Explicit IPv4 CIDR block of the peer VPC. When set, the module uses this value instead of reading it from the aws_vpc data source. See this_vpc_cidr for rationale. If empty, the CIDR is read from the data source (default behavior)."
  type        = string
  default     = ""
}

variable "use_ipv6" {
  description = "If ipv6 should be used"
  type        = bool
  default     = false
}
