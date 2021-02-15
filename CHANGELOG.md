v3.0.0
----
* Fixes `depends_on` issue ([#57](https://github.com/grem11n/terraform-aws-vpc-peering/issues/57))
* Added documentation regarding `depends_on` usage
* Run tests against Terraform 0.13 and 0.14
* Refactoring

v2.2.3
----
* Updated Terraform version and Go version for the tests
* Fixed [#48](https://github.com/grem11n/terraform-aws-vpc-peering/issues/48)
* Fixed [#52](https://github.com/grem11n/terraform-aws-vpc-peering/issues/52)

v2.2.2
----
* Fix quoted lines, which were triggering Terraform deprecation notices [#47](https://github.com/grem11n/terraform-aws-vpc-peering/pull/47)

v2.2.1
----
* Updated tests

v1.3.1
----
* Added deprecation notice for Terraform 0.11
* Updated the tests

v2.2.0
----
**Requires AWS provider version >=2.31.0!**

* Deprecates DNS options workaround since [hashicorp/terraform-provider-aws#6730](https://github.com/hashicorp/terraform-provider-aws/issues/6730) is fixed

v1.3.0
----
**Requires AWS provider version >=2.31.0!**

* Deprecates DNS options workaround since [hashicorp/terraform-provider-aws#6730](https://github.com/hashicorp/terraform-provider-aws/issues/6730) is fixed

v2.1.1
----
* Implements change ([#35](https://github.com/grem11n/terraform-aws-vpc-peering/pull/35)), which fixes ([#32](https://github.com/grem11n/terraform-aws-vpc-peering/issues/32)) for Terraform version `>= 0.12`
* Migrate CI to GitHub Actions and tests refactoring

v2.1.0
----
* Fix workaround for inter-region peering. See: [this issue](https://github.com/terraform-providers/terraform-provider-aws/issues/6730)
* Tests for different peering scenarios
* Docs and examples updates

v1.2.0
----
* Create a test case for a single account, single region peering
* Add example configuration for a single account, single region peering, which is tested
* Updated README
* Marked value `create_peering` for deprecation
* Added test for cross-region peering in the same AWS account
* Fixed cross-region peering for TF < 0.12 version

v1.1.0
----
* **Breaking change**: variable `owner_account_id` changed to `peer_account_id` for clarity. Please, update your configuration ([#13](https://github.com/grem11n/terraform-aws-vpc-peering/pull/13))
* **Breaking change**: variable `cross_region_peering` is deprecated due to refactoring.
* Updated README
* Added CHANGELOG
* Added [AWS VPC Peering Connection Options](https://www.terraform.io/docs/providers/aws/r/vpc_peering_options.html)
* Refactored a lot to use the same code for both cross-region and same-region peering.

v1.0.0
----
* Added cross-region perring ([#11](https://github.com/grem11n/terraform-aws-vpc-peering/pull/11))
