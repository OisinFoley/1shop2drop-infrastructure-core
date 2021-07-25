# Subscription and Tenant Info
variable "tenant_id" { default = "" }
variable "subscription_id" { default = "" }

# Core Resource Group
variable "resource_group_region" { default = "" }
variable "resource_group_name" { default = "" }

# Container Registry
variable "container_registry_name" { default = "" }
variable "container_registry_sku_tier" { default = "" }

# Applications
variable "server_app_service_plan_name" { default = "" }
variable "server_app_service_sku_tier" { default = "" }
variable "server_app_service_size" { default = "" }
variable "server_app_service_name" { default = "" }
variable "use_32_bit_process" { default = "" }
variable "server_container_name" { default = "" }

# Webapp Storage
variable "webapp_storage_account_name" { default = "" }
variable "webapp_storage_container_name" { default = "" }
variable "storage_access_tier" { default = "" }
variable "allow_blob_public_access" { default = "" }