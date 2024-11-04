// This provider example is designed to work with Localstack.
// You need to have a real AWS provider configuration for the production usage.
provider "aws" {
  endpoints {
    ec2 = "http://localhost:4566"
    s3  = "http://localhost:4566"
    sts = "http://localhost:4566"
  }
  region                      = "eu-west-1"
  access_key                  = "null"
  secret_key                  = "null"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
}