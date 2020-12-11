terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.21.0"
    }
  }
}

provider "aws" {
  alias = "this"
}

provider "aws" {
  alias = "peer"
}
