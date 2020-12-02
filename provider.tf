# Providers are required because of cross-region
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  alias  = "this"
  region = var.this_region
}

provider "aws" {
  alias  = "peer"
  region = local.peer_region_final
}
