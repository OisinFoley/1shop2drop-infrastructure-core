#!/bin/bash
set -euo pipefail

# Connect to remote backends.
printf "Connecting to '%s' remote backends: applications"

cd applications
printf "\n\nConnecting to /applications remote backend...\n"
terraform init -backend-config=../remote-backend/terraform.tfvars -reconfigure

cd ../../

printf "\nFinished connecting to '%s' remote backends \n"