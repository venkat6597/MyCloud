provider "azurerm" {
  features {}

}

data "azurerm_client_config" "current" {}


locals {
  secret_list = {
    "certificate-data" = var.certificate_data
    "certificate-pass" = var.certificate_pass
  }
  keyvault_name = "${var.application_gateway_name}-kv01"
  probe_values = [{
  
    pick_host_name_from_backend_http_settings = true
    name                                      = "Health_Probe_for_Port_443"
    path                                      = "/"
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    protocol                                  = "https"

    },
    {
      pick_host_name_from_backend_http_settings = true
      name                                      = "Health_Probe_for_Port_80"
      path                                      = "/"
      interval                                  = 30
      timeout                                   = 30
      unhealthy_threshold                       = 3
      protocol                                  = "http"
    }]


}


#Keyvault Integration
module "keyvault" {

  count                           = var.keyvault_id == "" && var.certificate_data != "" ? 1 : 0
  keyvault_id                     = var.keyvault_id
  source                          = ""
  keyvault_name                   = local.keyvault_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  sku_name                        = var.sku_name
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  purge_protection_enabled        = var.purge_protection_enabled
  soft_delete_retention_days      = var.soft_delete_retention_days
  create_resource_group           = var.create_resource_group
  object_id                       = var.object_id
  ip_rules                        = var.ip_rules
  virtual_network_subnet_ids      = var.virtual_network_subnet_ids
  key_permissions                 = var.key_permissions
  secret_permissions              = var.secret_permissions
  storage_permissions             = var.storage_permissions
  create_keyvault_secret          = var.create_keyvault_secret
  create_private_endpoint         = var.create_private_endpoint
  subnet_name                     = var.subnet_name
  virtual_network_name            = var.virtual_network_name
  vnet_resource_group_name        = var.vnet_resource_group_name
  default_action                  = var.default_action
  secret_list                     = local.secret_list

}





#Data Source to retreive Secrets
data "azurerm_key_vault_secret" "secret" {
  count        = var.keyvault_id != "" ? 1 : 0
  name         = var.ssl_secret_name
  key_vault_id = var.keyvault_id

}

data "azurerm_key_vault_secret" "secretpass" {
  count        = var.keyvault_id != "" ? 1 : 0
  name         = var.ssl_secret_password
  key_vault_id = var.keyvault_id



}



#Data Source to fetch subnet
data "azurerm_subnet" "gatewaysubnet" {
  name                 = var.gateway_subnet_name
  resource_group_name  = var.appgw_vnet_resource_group_name
  virtual_network_name = var.appgw_virtual_network_name
}

#Resource group creation
resource "azurerm_resource_group" "example" {
  count    = var.enable_resource_group ? 1 : 0
  name     = var.appgw_resource_group_name
  location = var.rg-location


}

#Application Gateway creation
resource "azurerm_application_gateway" "app_gateway" {
  count               = var.application_gateway_create ? 1 : 0
  name                = var.application_gateway_name
  resource_group_name = var.appgw_resource_group_name
  location            = var.rg-location

  sku {
    name     = var.gateway_tier_name
    tier     = var.gateway_tier
    capacity = var.capacity
  }

  gateway_ip_configuration {
    name      = var.gateway_subnet_name
    subnet_id = data.azurerm_subnet.gatewaysubnet.id
  }

  dynamic "backend_address_pool" {
    for_each = var.rules

    content {

      name         = backend_address_pool.value["backend_address_pool_name"]
      fqdns        = ["${backend_address_pool.value["webappName"]}.azurewebsites.net"]
      ip_addresses = var.backend_ip_address
    }
  }



  frontend_ip_configuration {

    name                          = var.frontendIP_config_name
    subnet_id                     = data.azurerm_subnet.gatewaysubnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
    private_ip_address            = var.private_ip_address_allocation == "Static" ? var.static_private_ip : 0
  }



  dynamic "frontend_port" {
    for_each = var.rules

    content {

      name = coalesce(frontend_port.value["frontendPort_name"], "default_frontend_port")
      port = coalesce(frontend_port.value["frontend_port"], "443")
    }
  }

  dynamic "http_listener" {
    for_each = var.rules

    content {

      name                           = coalesce(http_listener.value["http_listener_name"], "default_listener")
      frontend_ip_configuration_name = coalesce(var.frontendIP_config_name, "default_frontend_IP")
      frontend_port_name             = coalesce(http_listener.value["frontendPort_name"], "default_port_name")
      protocol                       = coalesce(http_listener.value["frontend_protocol"], "HTTPS")
      ssl_certificate_name           = "${var.application_gateway_name}-certificate"
    }
  }

  ssl_certificate {
    name     = "${var.application_gateway_name}-certificate"
    data     = var.keyvault_id != "" ? data.azurerm_key_vault_secret.secret[0].value : var.certificate_data
    password = var.keyvault_id != "" ? data.azurerm_key_vault_secret.secretpass[0].value : var.certificate_pass
  }

  dynamic "request_routing_rule" {
    for_each = var.rules

    content {

      name                       = coalesce(request_routing_rule.value["rule_name"], "default_rule_name")
      rule_type                  = "Basic"
      http_listener_name         = coalesce(request_routing_rule.value["http_listener_name"], "default_listener")
      backend_address_pool_name  = coalesce(request_routing_rule.value["backend_address_pool_name"], "default_backendpool_name")
      backend_http_settings_name = coalesce(request_routing_rule.value["backend_http_settings_name"], "default_backendhttpsettings_name")
    }


  }


  dynamic "backend_http_settings" {

    for_each = var.rules

    content {
      name                                = coalesce(backend_http_settings.value["backend_http_settings_name"], "default_backendhttpsettings_name")
      cookie_based_affinity               = "Disabled"
      port                                = coalesce(backend_http_settings.value["backend_port"], "443")
      protocol                            = coalesce(backend_http_settings.value["backend_protocol"], "HTTPS")
      request_timeout                     = 20
      pick_host_name_from_backend_address = true


    }



  }


  #WAF configuration for WAF tier
  waf_configuration {

    enabled                  = var.gateway_tier == "WAF" ? "true" : "false"
    firewall_mode            = "Detection"
    rule_set_type            = "OWASP"
    rule_set_version         = "3.0"
    request_body_check       = true
    file_upload_limit_mb     = 100
    max_request_body_size_kb = 128
  }

  


  dynamic "probe" {

    for_each = local.probe_values

    content {
      pick_host_name_from_backend_http_settings = probe.value.pick_host_name_from_backend_http_settings
      name                                      = probe.value.name
      path                                      = probe.value.path
      interval                                  = probe.value.interval
      timeout                                   = probe.value.timeout
      unhealthy_threshold                       = probe.value.unhealthy_threshold
      protocol                                  = probe.value.protocol
    }



  }

  depends_on = [
    module.keyvault
  ]

}