# Simple Peering

Configuration in this directory creates a simple peering connection between VPCs in a single region within the same AWS account.

## Usage

To run this example you need to execute

```bash
terraform init
terraform plan
terraform apply
```

## Note

Running the resources in AWS may cost money! Make sure to clean up afterwards. You can use `terraform destroy` to delete the resources spawned by this example.

## TODO:
* Create VPCs and route tables using this example. For now you can use for example [this module](https://github.com/terraform-aws-modules/terraform-aws-vpc/) to seyup prerequisites.
