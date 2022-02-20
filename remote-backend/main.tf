terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.54.0"
    }
  }
}

provider "azurerm" {
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id

  skip_provider_registration = true
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = var.resource_group_name
  location = var.resource_group_region
}

data "azurerm_resource_group" "default" {
  name = azurerm_resource_group.default.name
}

resource "azurerm_storage_account" "terraform_state" {
  name                = var.storage_account_name
  resource_group_name = data.azurerm_resource_group.default.name
  location            = data.azurerm_resource_group.default.location
  account_tier        = "Standard"
  blob_properties {
    delete_retention_policy {
      days = 30
    }
  }
  # Using GRS for higher availability and durability.
  # https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
  account_replication_type = "GRS"
}

# Enable versioning on storage account.
resource "azurerm_template_deployment" "terraform_state" {
  name                = "terraform-state-versioning"
  resource_group_name = data.azurerm_resource_group.default.name
  deployment_mode     = "Incremental"
  parameters = {
    "storageAccount" = azurerm_storage_account.terraform_state.name
  }

  template_body = <<DEPLOY
        {
            "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
            "contentVersion": "1.0.0.0",
            "parameters": {
                "storageAccount": {
                    "type": "string",
                    "metadata": {
                        "description": "Storage Account Name"}
                }
            },
            "variables": {},
            "resources": [
                {
                    "type": "Microsoft.Storage/storageAccounts/blobServices",
                    "apiVersion": "2019-06-01",
                    "name": "[concat(parameters('storageAccount'), '/default')]",
                    "properties": {
                        "IsVersioningEnabled": true
                    }
                }
            ]
        }
    DEPLOY
}

resource "azurerm_storage_container" "terraform_state" {
  name                 = "terraform-state"
  storage_account_name = azurerm_storage_account.terraform_state.name
}
