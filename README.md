# AWS VPC Peering Connection Module

## Welcome 👋

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

### Additional information for users from Russia and Belarus

* Russia has [illegally annexed Crimea in 2014](https://en.wikipedia.org/wiki/Annexation_of_Crimea_by_the_Russian_Federation) and [brought the war in Donbas](https://en.wikipedia.org/wiki/War_in_Donbas) followed by [full-scale invasion of Ukraine in 2022](https://en.wikipedia.org/wiki/2022_Russian_invasion_of_Ukraine).
* Russia has brought sorrow and devastations to millions of Ukrainians, killed hundreds of innocent people, damaged thousands of buildings, and forced several million people to flee.
* [Putin khuylo!](https://en.wikipedia.org/wiki/Putin_khuylo!)

Glory to Ukraine! 🇺

---

![terraform-aws-vpc-peering](https://github.com/grem11n/terraform-aws-vpc-peering/workflows/terraform-aws-vpc-peering/badge.svg)

---

This module configures VPC peering in different configurations.

These types of resources are supported:

* [AWS VPC Peering Connection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection)
* [AWS VPC Peering Connection Accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_accepter)
* [AWS VPC Peering Connection Options](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_options) \*
* [AWS Route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route)


## Important Notice

* \* - There is a bug with applying VPC peering options currently. You can still specify and manage them with this module, but you will need to run `apply` twice.
* Version `v3.1.*` supports both Terraform `0.14` and `0.15.0`. However, it throws warnings regarding empty providers deprecation. Provider configuration was changed in Terraform `0.15.0`. Therefore, newer versions would likely be incompatible with Terraform `<=0.15`. So, if you need to use both Terraform `0.14` and `0.15` at the same time or you're in the process of migration, please, use `v3.1.*` of this module.

## Features

This module configures VPC peering between two VPCs. Cross-account and cross-region configurations are supported as well.

You can also manage peering options, but you need to run `apply` twice to do that.

## Terraform Versions

**Always make sure you pinned the module version!**

* For Terraform versions `>=0.15` use `v4.*` versions of this module
* For Terraform versions `>=0.13` use `v3.*` versions of this module
* For Terraform versions `>=0.12 <0.13` use `v2.*` versions of this module
* If you're still using Terraform `0.11`, you can use `v1.*` versions of this module

## Usage

### Examples

Sample configuration is located in [examples](https://github.com/grem11n/terraform-aws-vpc-peering/blob/master/examples) directory.

* [Single account, single region peering](https://github.com/grem11n/terraform-aws-vpc-peering/blob/master/examples/single-account-single-region/README.md)
* [Single account, single region peering with options defined](https://github.com/grem11n/terraform-aws-vpc-peering/blob/master/examples/single-account-single-region-with-options/README.md)
* [Single account, cross region peering](https://github.com/grem11n/terraform-aws-vpc-peering/blob/master/examples/single-account-multi-region/README.md)
* [Cross account, cross region peering](https://github.com/grem11n/terraform-aws-vpc-peering/blob/master/examples/multi-account-multi-region/README.md)
* [Using depends_on with this module](https://github.com/grem11n/terraform-aws-vpc-peering/blob/master/examples/module-depends-on/README.md)


### Simple Peering (single AWS account, same region)

**Notice**: You need to declare both providers even with single region peering.

```hcl
module "single_account_single_region" {
  source = "../../"

  providers = {
    aws.this = aws
    aws.peer = aws
  }

  this_vpc_id = var.this_vpc_id
  peer_vpc_id = var.peer_vpc_id

  auto_accept_peering = true

  tags = {
    Name        = "tf-single-account-single-region"
    Environment = "Test"
  }
}
```

## Changelog

See the changelog on [the GitHub Releases page](https://github.com/grem11n/terraform-aws-vpc-peering/releases).

## Contribution

Your contribution to this module is more than welcome!

If you have an idea on how to improve this theme or found a bug feel free to use [GitHub issues](https://github.com/grem11n/terraform-aws-vpc-peering/issues) to let me know.

If you want to contribute to this theme, please, fork this repository and create a pull request. For recent versions of Terraform, open a PR against the `master` branch. For Terraform 0.12, please, open a PR against `terraform012` branch. For Terraform 0.11, please, open a PR against `terraform011` branch.

## Testing

This module is tested with [Terratest](https://github.com/gruntwork-io/terratest)
You can find existing tests in the [test/](https://github.com/grem11n/terraform-aws-vpc-peering/blob/master/test) directory.

Tests require AWS credentials. Since GitHub actions don't share the keys with fork repositories (on purpose), don't mind if tests for your PR failed. I will see it anyways and run them on my own. Alternatively, you can always run tests for your forks with your AWS credentials.

## Authors

Module managed by [Yurii Rochniak](https://github.com/grem11n)

[About me](https://grem1.in)

## License

Apache 2 License is applied. See [LICENSE](https://github.com/grem11n/terraform-aws-vpc-peering/blob/master/LICENSE) for full details.
