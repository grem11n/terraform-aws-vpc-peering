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
}

func TestPeeringActive(t *testing.T) {
	testCases := []TestCase{
		{"SingleAccountSingleRegion", "./fixtures/single-account-single-region", "../examples/single-account-single-region"},
		{"SingleAccountSingleRegionWithOptions", "./fixtures/single-account-single-region-with-options", "../examples/single-account-single-region-with-options"},
		{"SingleAccountMultiRegion", "./fixtures/single-account-multi-region", "../examples/single-account-multi-region"},
		{"MultiAccountSingleRegion", "./fixtures/multi-account-single-region", "../examples/multi-account-single-region"},
		{"MultiAccountMultiRegion", "./fixtures/multi-account-multi-region", "../examples/multi-account-multi-region"},
		{"ModuleDependsOn", "", "../examples/module-depends-on"},
		{"AssociatedCIDRs", "./fixtures/associated-cidr", "../examples/associated-cidrs"},
	}

	for _, tc := range testCases {
		t.Run(tc.Name, func(t *testing.T) {
			terratestRun(tc, t)
		})
	}
}

func terratestRun(tc TestCase, t *testing.T) {
	var tfVars = make(map[string]interface{})
	// Assertions
	expectedPeeringStatus := "active"

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

	// Retrieve information with `terraform output`
	actualPeeringStatus := terraform.Output(t, moduleTerraformOptions, "vpc_peering_accept_status")

	// Verify results
	assert.Equal(t, expectedPeeringStatus, actualPeeringStatus)
}
