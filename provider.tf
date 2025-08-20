terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 6"
      configuration_aliases = [aws.this, aws.peer]
    }
  }
}
