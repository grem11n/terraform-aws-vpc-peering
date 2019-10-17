# Single Account Multi Region VPC Peering

This example creates a peering connection between VPCs in different regions, which are located in the same AWS account.

## Sample Code

```
module "single_account_multi_region" {
  source = "../../"

  providers = {
    aws.this = aws.this
    aws.peer = aws.peer
  }

  this_vpc_id = var.this_vpc_id
  peer_vpc_id = var.peer_vpc_id

  auto_accept_peering = true

  tags = {
    Name        = "tf-single-account-multi-region"
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
