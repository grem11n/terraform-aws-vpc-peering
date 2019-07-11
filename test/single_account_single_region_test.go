package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestSingleAccountSingleRegion(t *testing.T) {
	testCases := []struct {
		Name        string
		fixturesDir string
		moduleDir   string
	}{
		{"SingleAccountSingleRegion", "./fixtures/single-account-single-region", "../examples/single-account-single-region"},
		{"SingleAccountSingleRegionWithOptions", "./fixtures/single-account-single-region-with-options", "../examples/single-account-single-region-with-options"},
	}

	for _, tc := range testCases {
		t.Run(tc.Name, func(t *testing.T) {
			// Assertions
			expectedPeeringStatus := "active"

			// Terraform Options for fixtures
			fixturesTerraformOptions := &terraform.Options{
				TerraformDir: tc.fixturesDir,
			}

			// Remove the fixtures resources in the end of the test
			defer terraform.Destroy(t, fixturesTerraformOptions)

			// Install Prerequisites
			terraform.InitAndApply(t, fixturesTerraformOptions)

			// Get the outputs from fixtures
			thisVpcID := terraform.Output(t, fixturesTerraformOptions, "this_vpc_id")
			peerVpcID := terraform.Output(t, fixturesTerraformOptions, "peer_vpc_id")

			// Terraform Options for module
			moduleTerraformOptions := &terraform.Options{
				TerraformDir: tc.moduleDir,
				// Variables from the fixtures
				Vars: map[string]interface{}{
					"this_vpc_id": thisVpcID,
					"peer_vpc_id": peerVpcID,
				},
			}

			// Remove the module resources in the end of the test
			defer terraform.Destroy(t, moduleTerraformOptions)

			// Create module resources
			terraform.InitAndApply(t, moduleTerraformOptions)

			// Retrieve information with `terraform output`
			actualPeeringStatus := terraform.Output(t, moduleTerraformOptions, "vpc_peering_accept_status")

			// Verify results
			assert.Equal(t, expectedPeeringStatus, actualPeeringStatus)

		})
	}
}
