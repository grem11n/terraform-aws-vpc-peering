#!/bin/bash
set -ev

if [ "${TRAVIS_BRANCH}" == "terraform011" ]; then
	TF_VERSION=0.11.11
else
	TF_VERSION=0.12.1
fi

wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip -O /tmp/terraform.zip

sudo unzip -d /usr/local/bin/ /tmp/terraform.zip
