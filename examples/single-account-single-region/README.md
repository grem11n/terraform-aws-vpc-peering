# Single Account Single Region VPC Peering

This is a basic configuration example, which creates a peering connection between VPCs in a single region within the same AWS account.

## Code Sample

```
module "single_account_single_region" {
  source = "../../"

  providers = {
    aws.this = "aws"
    aws.peer = "aws"
  }

  this_vpc_id = "${var.this_vpc_id}"
  peer_vpc_id = "${var.peer_vpc_id}"

  create_peering      = true
  auto_accept_peering = true

  tags = {
    Name        = "tf-single-account-single-region"
    Environment = "Test"
  }
}
```

## Usage

Change the variables to fit your purposes and run:

```bash
terraform init
terraform plan
terraform apply
```

## Testing

This configuration is tested with [Terratest](https://github.com/gruntwork-io/terratest).

You can find tests in [`test/`](../../test) directory.

## Note

Running the resources in AWS may cost money! Make sure to clean up afterwards. You can use `terraform destroy` to delete the resources spawned by this example.
