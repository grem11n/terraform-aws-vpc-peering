# Single Account Single Region VPC Peering

This is a basic configuration example, which creates a peering connection between VPCs in a single region within the same AWS account.

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
