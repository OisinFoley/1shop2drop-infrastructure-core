module "app_insights" {
  source = "github.com/oisinfoley/1shop2drop-infrastructure-modules.git?ref=0.2.0//app-insights"

  resource_group_name       = data.azurerm_resource_group.core_infrastructure.name
  resource_group_region     = data.azurerm_resource_group.core_infrastructure.location
  server_app_insights_name  = var.server_app_insights_name
  application_type          = var.app_insights_application_type
}