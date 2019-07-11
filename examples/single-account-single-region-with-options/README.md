# Single Account Single Region Peering Connection with Peering Options

Configuration in this directory creates a peering connection between VPCs in a single region within the same AWS account. It also creates connection options:

* Cross-VPC DNS resolution option
* Allow classic link access between VPCs

## Usage

Modify the variables to suite your purposes. Then run:

```bash
terraform init
terraform plan
terraform apply
```

## Testing

This configuration is tested with [Terratest](https://github.com/gruntwork-io/terratest).

You can find tests in [`test/`](../../test) directory.

### Testing notes

I'm unable to properly test VPC peering options because I need to create public subnets (which contain AWS Internet Gateway) and some resources in Classic. These costs money and I don't want to add it to thr CI. Therefore, tests for this module inplementation simply test that module is able to run and peering is created.

## Note

Running the resources in AWS may cost money! Make sure to clean up afterwards. You can use `terraform destroy` to delete the resources spawned by this example.
