#!/bin/bash
set -euo pipefail

declare environments=("dev" "test")

# Create remote backend.
cd remote-backend
printf "Creating remote backend...\n\n"

terraform init

for environment in "${environments[@]}"
do
  printf "\nCreating '%s' remote backend...\n\n" "${environment}"
  terraform apply -var-file="${environment}.tfvars"
  rm terraform.tfstate*
done

printf "\nFinished creating remote backend...\n"
