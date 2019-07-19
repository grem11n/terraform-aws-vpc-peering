Unreleased
----

* Tests for cross-account / cross-region peering configuration
* Mark variable `peer_account_id` for deprecation

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
