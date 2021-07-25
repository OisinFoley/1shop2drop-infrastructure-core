# Cloud Infrastructure Core for 1shop2drop

## Table of Contents

[Introduction](#introduction)

[Getting started](#getting-started)

[How to create a copy of the cloud infrastructure used by 1shop2drop](#how-to-create-a-copy-of-the-cloud-infrastructure-used-by-1shop2drop)

[Remote Storage](#remote-storage)

[Deploying Across Different Tenants or Subscriptions](#deploying-across-different-tenants-or-subscriptions)

## Introduction

The cloud infrastructure runs on Azure and uses Terraform to provision the resources used.

Components of the 1shop2drop system that are provisioned by these repos make use of the following Azure resources:

- **Backend**: App Service plan, App Service, Container registry, StorageAccount

## Getting started

### Tools

If on Mac:

- Install [Homebrew](https://brew.sh/):

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

- Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli):

```
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

Run `terraform version` to verify installation.

In future, to update to latest:

```
brew upgrade hashicorp/tap/terraform
```

- Install [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli):

```
brew update && brew install azure-cli
```

If not on Mac:

- [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

Options for IDE support include [IntelliJ](https://www.jetbrains.com/idea/)'s
[HashiCorp Terraform / HCL Language Support](https://plugins.jetbrains.com/plugin/7808-hashicorp-terraform--hcl-language-support)
plugin for Terraform, and also [Visual Studio Code](https://code.visualstudio.com/)'s
[HashiCorp Terraform](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform) plugin.

### Dependencies

You'll need to clone the Terraform modules repo:

```
git clone https://github.com/oisinfoley/1shop2drop-infrastructure-modules.git
```

If you would like to test development changes to the `1shop2drop-infrastructure-modules` dependency locally, simply place the downloaded folder containing this repo - as well as the folder containing the `1shop2drop-infrastructure-modules` repo at the same directory.  
Then, in this repo, update each `module` block's `source` attribute so that it mimics the following example:

```
module "app_service" {
  # Add this
  source = "../../1shop2drop-infrastructure-modules/app-service"

  # Remove this
  # source = "github.com/oisinfoley/1shop2drop-infrastructure-modules.git//app-service"
}
```

## How to create a copy of the cloud infrastructure used by 1shop2drop

1. Fork this repository.
2. Run `az login` (Azure CLI required) and login in the browser.
3. From root directory of this repo, run `sh scripts/create-remote-backends.sh`, this will create a stroage account in Azure which is used to remotely store the current state of the deployment so that the state of the deployed infrastructure is not lost if this repo is deleted from your local machine.
   This allows developers to see the current deployment state even when working from separate machines.
4. Run `cd applications`
5. Run `Terraform init`, followed by `Terraform plan` - this shows a preview of what will be created during next deployment, but doesn't deploy anything yet
6. Read the output of what will be created during next deployment and ensure you're satisfied with proposed changes
7. Run `terraform apply`, then type `yes` (to skip the requirment for answering `yes`, provide `-auto-approve` flag when executing `terraform apply` command)
8. Repeat step 4 (but replace the sub-directory name) for any other relevant directories containing module definitions

## Remote Storage

- We store the current state of the infrastructure deployment in a remote location in Azure Blob Storage, to ensure accurate record of current state is available to multiple clients if necessary, and to adhere to Terraform best practices.
- Additional Azure Blob Storage account is used to serve the JavaScript assets containing the 1shop2drop webapp.

## Deploying Across Different Tenants or Subscriptions

- Update the values you specify for `tenant_id` and `subscription_id` in a `*.tfvars` file (preferred), or add values to the variables initalised in the `variables.tf` files in order to deploy the infrastructure across different subscriptions in Azure.

### Variable files

`variables.tf` contains variables which are common/shared by all resources.  
To ensure no values are accidentally committed, this file is just being used to initialise variables, with the expectation being that one will use a `*.tfvars` file when running the `terraform plan` or `terraform apply` commands.
Symbolic links to the root directory's `variables.tf` file in `/applications` with the idea being that it'll be easier to branch out into new directorys (e.g. - databases) as time goes on.  
If you create new sub-directories in the future, you can create your own soft-link from `variables.tf` to the new directory with the following command:  
`(if in directory you want to output the file to) ln -s ../variables.tf ./variables.tf`

### Examples

- variables.tfvars, defining values

```
tenant_id =  "e033d626-4ce4-4730-93dd-df6cd7156c34"
subscription_id = "2876jhb-4ss4-3230-99wd-df6cdkjbc342"
```

- Terminal command passing flag to override default variables.tf values with values from a variables.tfvars file

```
terraform plan -var-file=variables.tfvars
```
