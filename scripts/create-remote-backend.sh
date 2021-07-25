#!/bin/bash
set -euo pipefail

declare environment_file=("terraform")

# Create remote backend.
cd remote-backend
printf "Creating remote backend...\n\n"

terraform init -reconfigure
terraform apply -var-file="${environment_file}.tfvars"

rm terraform.tfstate*

printf "\nFinished creating remote backend...\n"
