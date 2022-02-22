
data "http" "ip" {
  url = "https://ifconfig.me"
}
data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group  ? 1 : 0
  name     = var.resource_group_name
  location = var.location

 
}

resource "azurerm_key_vault" "keyvault" {

  name                        = var.keyvault_name
  location                    = var.location
  resource_group_name         = var.create_resource_group ? azurerm_resource_group.rg[0].name : var.resource_group_name
  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  enabled_for_deployment      = var.enabled_for_deployment
  enabled_for_template_deployment= var.enabled_for_template_deployment
  enable_rbac_authorization   = var.enable_rbac_authorization
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = var.purge_protection_enabled
  sku_name                    = var.sku_name
  access_policy               = []
  

   network_acls {
     default_action = var.default_action
     bypass         = var.bypass
     ip_rules       = length(var.ip_rules) > 0 ? concat([data.http.ip.body],var.ip_rules) : [data.http.ip.body]
     virtual_network_subnet_ids = length(var.virtual_network_subnet_ids) > 0 ? var.virtual_network_subnet_ids : null
   }
   depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_key_vault_access_policy" "access_policy" {
  count               = var.enable_rbac_authorization  ? 0 : 1
  key_vault_id        = azurerm_key_vault.keyvault.id
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = length(var.object_id) > 0 ? var.object_id : data.azurerm_client_config.current.object_id
  key_permissions     = var.key_permissions
  secret_permissions  = var.secret_permissions
  storage_permissions = var.storage_permissions

  

  
}
data "azurerm_subscription" "current" {
}

resource "azurerm_key_vault_secret" "key_vault_secret" {
  count = var.create_keyvault_secret  ? length(var.secret_list) : 0
  name = keys(var.secret_list)[count.index]
  value = values(var.secret_list)[count.index]
  key_vault_id = azurerm_key_vault.keyvault.id

  depends_on = [
    azurerm_key_vault_access_policy.access_policy
  ]
}

resource "azurerm_private_endpoint" "endpoint" {
  count               = var.create_private_endpoint  && var.sku_name == "premium"  ? 1 : 0  
  name                = "${var.keyvault_name}_endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${var.vnet_resource_group_name }/providers/Microsoft.Network/virtualNetworks/${var.virtual_network_name}/subnets/${var.subnet_name}"
  private_service_connection {
      name                              = "${var.keyvault_name}_private_link"
      is_manual_connection              = false
      private_connection_resource_id    = azurerm_key_vault.keyvault.id
      subresource_names                 = ["vault"]
  }

}