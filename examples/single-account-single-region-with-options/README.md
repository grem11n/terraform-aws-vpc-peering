# Single Account Single Region Peering Connection with Peering Options

Configuration in this directory creates a peering connection between VPCs in a single region within the same AWS account. It also creates connection options:

* Cross-VPC DNS resolution option
* Allow classic link access between VPCs

## Code Sample

```
module "single_account_single_region_options" {
  source = "../../"

  providers = {
    aws.this = "aws"
    aws.peer = "aws"
  }

  this_vpc_id = var.this_vpc_id
  peer_vpc_id = var.peer_vpc_id

  auto_accept_peering = true

  // Peering options for requester
  this_dns_resolution        = true
  this_link_to_peer_classic  = true
  this_link_to_local_classic = true

  // Peering options for accepter
  peer_dns_resolution        = true
  peer_link_to_peer_classic  = true
  peer_link_to_local_classic = true

  tags = {
    Name        = "tf-single-account-single-region-with-options"
    Environment = "Test"
  }
}
```

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
