terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 4"
      configuration_aliases = [aws.this, aws.peer]
    }
  }
}
