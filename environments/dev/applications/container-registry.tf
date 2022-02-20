module "container_registry" {
  source = "github.com/oisinfoley/1shop2drop-infrastructure-modules.git?ref=0.1.1//container-registry"

  resource_group_name          = data.azurerm_resource_group.core_infrastructure.name
  resource_group_location      = data.azurerm_resource_group.core_infrastructure.location
  container_registry_name      = var.container_registry_name
  container_registry_sku_tier  = var.container_registry_sku_tier
}
