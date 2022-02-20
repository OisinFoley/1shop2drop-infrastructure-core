# Subscription and Tenant Info
variable "tenant_id" { default = "e033d626-4ce4-4730-93dd-df6cd7156c34" }
variable "subscription_id" { default = "3d45449c-e5b9-4020-a637-6918d0561e14" }

# Core Resource Group
variable "resource_group_region" { default = "North Europe" }

# Container Registry
variable "container_registry_sku_tier" { default = "Basic" }

# Applications
variable "server_app_service_sku_tier" { default = "Standard" }
variable "server_app_service_size" { default = "S2" }
variable "server_container_name" { default = "1shop2drop" }
variable "use_32_bit_process" { default = "false" }

# Webapp Storage
variable "webapp_storage_container_name" { default = "webapp" }
variable "storage_access_tier" { default = "Cool" }
variable "allow_blob_public_access" { default = "true" }