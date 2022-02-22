variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}

variable "location" {
  type        = string
  description = "RG location in Azure"
}

variable "create_module" {
  type = bool
  default = false
}

variable "keyvault_name" {
  type        = string
  description = "Key Vault name in Azure"
}

variable "sku_name" {
  type        = string
  default     = "standard"
}

variable "enabled_for_disk_encryption" {
  type       = bool
  default    = false
}

variable "enabled_for_deployment" {
  type       = bool
  default    = false
}

variable "enabled_for_template_deployment" {
  type       = bool
  default    = false
}

variable "enable_rbac_authorization" {
  type       = bool
  default    = false
}

variable "purge_protection_enabled" {
  type       = bool
  default    = false
}
variable "soft_delete_retention_days" {
    type      = number
    default   = 7
}

variable "create_resource_group" {
    type      = bool
    default   = false
}

variable "object_id" {
   type     = string
   default  = ""
}

variable "ip_rules" {
   type = list(string)
   default = []
}

variable "virtual_network_subnet_ids" {
   type = list(string)
   default = []
}

variable "key_permissions"{
  type     = list(string)
  default  = [ "get", ]
}

variable "secret_permissions"{
  type     = list(string)
  default  = [ "get", "list", "set", "delete" ]
}

variable "storage_permissions"{
  type     = list(string)
  default  = [ "get", ]
}

variable "create_keyvault_secret" {
    type      = bool
    default   = false
}


variable "create_private_endpoint" {
  type = bool
  default = false
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = ""
}
variable "virtual_network_name" {
  description = "Virtual network name"
  type        = string
  default     = ""
}
variable "vnet_resource_group_name" {
  description = "vnet resource group"
  type        = string
  default     = ""
}

variable "default_action" {
  type = string
  default = "Allow"
}

variable "bypass" {
  type = string
  default = "AzureServices"
}
variable "secret_list" {
  type = map(any)
  default = {
    "" = ""
  }
}


variable "keyvault_id" {
  type = string
  
}