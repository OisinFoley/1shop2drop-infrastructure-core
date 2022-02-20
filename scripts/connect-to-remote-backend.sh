#!/bin/bash
set -euo pipefail

declare -a environments=("dev" "test")

cd environments
printf "Connecting to '%s' remote backends..." "${environments[*]}"

for environment in "${environments[@]}"
do
  cd "${environment}"/applications
  printf "\n\nConnecting to '%s/applications' remote backend...\n" "${environment}"
  terraform init -backend-config=../../../remote-backend/"${environment}".tfvars
  cd ../../
done

printf "\nFinished connecting to '%s' remote backends \n" "${environments[*]}"