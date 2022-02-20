# Core Resource Group
variable "resource_group_name" { default = "1S2D-dev-core-rg" }

# Container Registry
variable "container_registry_name" { default = "1s2ddevcontainerreg" }

# Applications
variable "server_app_service_plan_name" { default = "1S2D-dev-app-service-plan" }
variable "server_app_service_name" { default = "1S2D-dev-app-service" }
variable "always_on" { default = "false" }

# Webapp Storage
variable "webapp_storage_account_name" { default = "1s2ddevstrg" }