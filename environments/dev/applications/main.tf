terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.54.0"
    }
  }

  backend "azurerm" {
    /*
       resource_group_name & storage_account_name are specified in remote-backend/main.tf's
       terraform_state block.
    */
    resource_group_name  = var.resource_group_name
    storage_account_name = var.storage_account_name
    container_name       = "terraform-state"
    key                  = "applications/terraform.tfstate"
  }
}

provider "azurerm" {
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id

  skip_provider_registration = true
  features {}
}

resource "azurerm_resource_group" "core_infrastructure" {
  name     = var.resource_group_name
  location = var.resource_group_region
}

data "azurerm_resource_group" "core_infrastructure" {
  name = azurerm_resource_group.core_infrastructure.name
}