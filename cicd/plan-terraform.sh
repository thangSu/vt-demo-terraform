#!/bin/bash
cd ..
# initialize terraform
terraform init -migrate-state
# plan
terraform plan 