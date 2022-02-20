module "app_service" {
  source = "github.com/oisinfoley/1shop2drop-infrastructure-modules.git?ref=0.1.1//app-service"

  resource_group_name                 = data.azurerm_resource_group.core_infrastructure.name
  resource_group_region               = data.azurerm_resource_group.core_infrastructure.location
  server_app_service_plan_name        = var.server_app_service_plan_name
  server_app_service_sku_tier         = var.server_app_service_sku_tier
  server_app_service_name             = var.server_app_service_name
  server_app_service_size             = var.server_app_service_size
  always_on                           = var.always_on
  use_32_bit_process                  = var.use_32_bit_process
  server_container_name               = var.server_container_name
  container_registry_name             = module.container_registry.container_registry_name
  container_registry_password         = module.container_registry.container_registry_password
}
