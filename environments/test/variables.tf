# Core Resource Group
variable "resource_group_name" { default = "1S2D-test-core-rg" }

# Container Registry
variable "container_registry_name" { default = "1s2dtestcontainerreg" }

# Applications
variable "server_app_service_plan_name" { default = "1S2D-test-app-service-plan" }
variable "server_app_service_name" { default = "1S2D-test-app-service" }

# Webapp Storage
variable "webapp_storage_account_name" { default = "1s2dteststrg" }
variable "always_on" { default = "true" }