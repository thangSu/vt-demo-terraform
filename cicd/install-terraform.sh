#!/bin/bash

# Update package list
sudo apt update

# Install required packages
sudo apt install -y curl unzip

# Download Terraform binary
curl -O https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_linux_amd64.zip

# Unzip Terraform binary
unzip terraform_1.0.11_linux_amd64.zip

# Move Terraform binary to /usr/local/bin directory
sudo mv terraform /usr/local/bin/

# Verify Terraform installation
terraform --version
