#!/bin/bash

#go back to the root directory
cd ..
# initialize terraform
terraform init
# apply terraform
terraform apply -auto-approve

