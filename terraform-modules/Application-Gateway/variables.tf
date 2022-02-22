variable "rg-location" {
  default     = "northeurope"
  description = "Geographic location for the app gateway"
  type        = string
}


variable "enable_resource_group" {

  type        = bool
  default     = false
  description = "Boolean value for enabling resource group"
}

variable "appgw_resource_group_name" {
  description = "Resource group for App gateway "
  type        = string
  default     = ""

}

variable "application_gateway_create" {
  description = "creation of application gateway"
  type        = bool
  default     = true

}


variable "application_gateway_name" {
  description = "Name of the App Gateway"
  type        = string
  default     = ""
}



variable "frontendIP_config_name" {
  description = "Name of the FrontEnd IP"
  type        = string
  default     = ""
}


variable "gateway_tier_name" {
  description = "The Name of the SKU to use for this Application"
  default     = ""
  type        = string
  validation {
    condition = anytrue([
      var.gateway_tier_name == "Standard_Small",
      var.gateway_tier_name == "Standard_Medium",
      var.gateway_tier_name == "Standard_Large",
      var.gateway_tier_name == "WAF_Medium",
      var.gateway_tier_name == "WAF_Large"
    ])
    error_message = "Tier name must be Standard_Small, Standard_medium, Standard_Large, WAF_Medium , WAF_Large."
  }
}



variable "gateway_tier" {
  description = "The Tier of the SKU to use for this Application Gateway"
  default     = ""
  type        = string
  validation {
    condition = anytrue([
      var.gateway_tier == "Standard",
      var.gateway_tier == "WAF"
    ])
    error_message = "Tier must be Standard or WAF."
  }


}

variable "private_ip_address_allocation" {
  type        = string
  default     = "Dynamic"
  description = "The Allocation Method for the Private IP Address. Possible values are Dynamic and Static"

}

variable "static_private_ip" {
  type        = string
  description = "IP address for Static Private IP"

}
variable "capacity" {
  description = "The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32"
  type        = number
  default     = 2
}

variable "appgw_vnet_resource_group_name" {
  description = "Resource group for the Vnet"
  type        = string

}

variable "appgw_virtual_network_name" {
  description = "Name of the virtual network"
  type        = string

}

variable "backend_ip_address" {
  description = "IP address for backend pool"
  type        = list(string)

}


variable "gateway_subnet_name" {
  description = "Name of the gateway subnet"
  type        = string


}



variable "keyvault_id" {
  description = "The Vault ID."
  default     = ""
}




variable "ssl_secret_name" {
  description = "The name of the associated SSL Certificate which should be used for the HTTP Listener"
  type        = string
}
variable "ssl_secret_password" {
  description = "The name of the associated SSL Certificate password which should be used for the HTTP Listener"
}





variable "rules" {
  type        = list(map(string))
  description = "Rule holds value for http_listener_name , backend_address_pool_name , backend_http_settings_name , webappName, frontend_port & name , frontend & backend protocol "


}








#Keyvault



variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}

variable "location" {
  type        = string
  description = "RG location in Azure"
}


variable "sku_name" {
  type    = string
  default = "standard"
}

variable "enabled_for_disk_encryption" {
  type    = bool
  default = false
}

variable "enabled_for_deployment" {
  type    = bool
  default = false
}

variable "enabled_for_template_deployment" {
  type    = bool
  default = false
}

variable "enable_rbac_authorization" {
  type    = bool
  default = false
}

variable "purge_protection_enabled" {
  type    = bool
  default = false
}
variable "soft_delete_retention_days" {
  type    = number
  default = 7
}

variable "create_resource_group" {
  type    = bool
  default = false
}

variable "object_id" {
  type    = string
  default = ""
}

variable "ip_rules" {
  type    = list(any)
  default = []
}

variable "virtual_network_subnet_ids" {
  type    = list(any)
  default = []
}

variable "key_permissions" {
  type    = list(string)
  default = ["get", ]
}

variable "secret_permissions" {
  type    = list(string)
  default = ["get", "list", "set", "delete"]
}

variable "storage_permissions" {
  type    = list(string)
  default = ["get", ]
}

variable "create_keyvault_secret" {
  type    = bool
  default = false
}

variable "keyvault_secret" {
  type    = any
  default = ""
}

variable "create_private_endpoint" {
  type    = bool
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
  type    = string
  default = "Deny"
}



variable "secret_list" {
  type = map(any)
  default = {
    "" = ""
  }
}

variable "certificate_data" {

}

variable "certificate_pass" {

}