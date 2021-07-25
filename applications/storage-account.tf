module "storage_account" {
  source = "github.com/oisinfoley/1shop2drop-infrastructure-modules.git?ref=0.1.0//storage-account"

  resource_group_name              = data.azurerm_resource_group.core_infrastructure.name
  resource_group_region            = data.azurerm_resource_group.core_infrastructure.location
  webapp_storage_account_name      = var.webapp_storage_account_name
  container_name                   = var.webapp_storage_container_name
  storage_access_tier              = var.storage_access_tier
  allow_blob_public_access         = var.allow_blob_public_access
}
