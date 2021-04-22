package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

type TestCase struct {
	Name        string
	FixturesDir string
	ModuleDir   string
	Assertion   map[string]interface{}
}

func TestPeeringActive(t *testing.T) {
	genericAssertion := map[string]interface{}{
		"vpc_peering_accept_status": "active",
	}

	// Terratest presents outputs of any type as strings
	expectedOptions := `[
  {
    "allow_classic_link_to_remote_vpc" = true
    "allow_remote_vpc_dns_resolution" = true
    "allow_vpc_to_remote_classic_link" = true
  },
]`

	optionsAssertions := map[string]interface{}{
		"vpc_peering_accept_status": "active",
		"accepter_options":          expectedOptions,
	}

	testCases := []TestCase{
		{"SingleAccountSingleRegion", "./fixtures/single-account-single-region", "../examples/single-account-single-region", genericAssertion},
		{"SingleAccountSingleRegionWithOptions", "./fixtures/single-account-single-region-with-options", "../examples/single-account-single-region-with-options", optionsAssertions},
		{"SingleAccountMultiRegion", "./fixtures/single-account-multi-region", "../examples/single-account-multi-region", genericAssertion},
		{"MultiAccountMultiRegion", "./fixtures/multi-account-multi-region", "../examples/multi-account-multi-region", genericAssertion},
		{"ModuleDependsOn", "", "../examples/module-depends-on", genericAssertion},
	}

	for _, tc := range testCases {
		t.Run(tc.Name, func(t *testing.T) {
			terratestRun(tc, t)
		})
	}
}

func terratestRun(tc TestCase, t *testing.T) {
	var tfVars = make(map[string]interface{})

	// Check if we need to apply fixtures first
	if tc.FixturesDir != "" {
		// Terraform Options for fixtures
		fixturesTerraformOptions := &terraform.Options{
			TerraformDir: tc.FixturesDir,
		}

		// Remove the fixtures resources in the end of the test
		defer terraform.Destroy(t, fixturesTerraformOptions)

		// Install Prerequisites
		terraform.InitAndApply(t, fixturesTerraformOptions)

		// Get the outputs from fixtures
		thisVpcID := terraform.Output(t, fixturesTerraformOptions, "this_vpc_id")
		peerVpcID := terraform.Output(t, fixturesTerraformOptions, "peer_vpc_id")

		tfVars["this_vpc_id"] = thisVpcID
		tfVars["peer_vpc_id"] = peerVpcID

	}

	// Terraform Options for module
	moduleTerraformOptions := &terraform.Options{
		TerraformDir: tc.ModuleDir,
		// Variables from the fixtures
		Vars: tfVars,
	}

	// Remove the module resources in the end of the test
	defer terraform.Destroy(t, moduleTerraformOptions)

	// Create module resources
	terraform.InitAndApply(t, moduleTerraformOptions)

	// Verify results
	for output, expectedResult := range tc.Assertion {
		got := terraform.Output(t, moduleTerraformOptions, output)
		assert.Equal(t, expectedResult, got)
	}
}
