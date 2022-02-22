#Resource details
application_gateway_create = true
rg-location                = ""
enable_resource_group      = true
appgw_resource_group_name  = ""
application_gateway_name   = ""
frontendIP_config_name     = ""

#Sku 
gateway_tier_name = ""
gateway_tier      = ""
capacity          = 2

#Vnet Details
appgw_vnet_resource_group_name = ""
appgw_virtual_network_name     = ""
gateway_subnet_name            = ""

#Frontend private ip allocation
private_ip_address_allocation = "Dynamic"
static_private_ip             = "1"

#backend pool IP
backend_ip_address = [""]

#Keyvault ID

keyvault_id = ""


#Vault secret for certificate and password 
ssl_secret_name     = "secret"
ssl_secret_password = "secret"



#Rules to be defined as map
rules = [
  {
    rule_name                  = ""
    http_listener_name         = ""
    backend_address_pool_name  = ""
    backend_http_settings_name = ""
    webappName                 = ""
    frontend_port              = ""
    backend_port               = ""
    frontendPort_name          = ""
    frontend_protocol          = ""
    backend_protocol           = ""
  }
  /*{
    rule_name                  = ""
    http_listener_name         = ""
    backend_address_pool_name  = ""
    backend_http_settings_name = ""
    webappName                 = ""
    frontend_port              = "447"
    backend_port               = "449"
    frontendPort_name          = ""
    frontend_protocol          = "https"
    backend_protocol           = "Https"



  }*/

]







#Keyvault 

resource_group_name             = ""
location                        = ""
sku_name                        = "standard"
enabled_for_disk_encryption     = true
enabled_for_deployment          = true
enabled_for_template_deployment = true
enable_rbac_authorization       = false
purge_protection_enabled        = false
soft_delete_retention_days      = 7
create_resource_group           = true
object_id                       = ""
ip_rules                        = []
virtual_network_subnet_ids      = ["sample"]
key_permissions                 = ["get", "list", "update", ]
secret_permissions              = ["get", "list", "delete", "recover", "backup", "restore", "set", ]
storage_permissions             = ["get", "list", "update", "delete", "recover", "backup", "restore", ]
create_keyvault_secret          = true
create_private_endpoint         = true
subnet_name                     = "keyvault"
virtual_network_name            = "sample"
vnet_resource_group_name        = "sample"
default_action                  = "Allow"
certificate_data                = ""
certificate_pass                = ""
