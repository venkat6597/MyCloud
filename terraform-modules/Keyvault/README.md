# KEY VAULT

## About 
Azure Key Vault is a cloud service for securely storing and accessing secrets.

Azure Key Vault helps solve the following problems:
Secrets Management - Azure Key Vault can be used to Securely store and tightly control access to tokens, passwords, certificates, API keys, and other secrets
Key Management - Azure Key Vault can also be used as a Key Management solution. Azure Key Vault makes it easy to create and control the encryption keys used to encrypt your data.
Certificate Management - Azure Key Vault is also a service that lets you easily provision, manage, and deploy public and private Transport Layer Security/Secure Sockets Layer (TLS/SSL) certificates for use with Azure and your internal connected resources.
Key Vault will be created with below permissions.
Secrets:Get,List,Set
Keys:Get,List,Update,Create
Certificates:Get,List

## Version compatibility

| Module version | Terraform version |
| -------------- | ----------------- |
| >= 2.85.0, <2.89.0"| >= 1.0.10    |

## How to Consume

This module is optimized to work with the [Azurerum-Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs) tool
which set some terraform variables in the environment needed by this module. For advanced configuration refer the input section for parameter detail.

You can use this module by including it this way:

```hcl

module "keyvault" {
  source                      = "hhttps://github.com/venkat6597/MyCloud/tree/main/terraform-modules/modules/Keyvault"
  name                        = keyvault_sample
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  enabled_for_deployment      = var.enabled_for_deployment
  enabled_for_template_deployment= var.enabled_for_template_deployment
  enable_rbac_authorization   = var.enable_rbac_authorization
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = false
  sku_name                    = "standard"

}

```

<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| azurerm |>= 2.85.0, <2.89.0"|

## Inputs
Fill following inputs in to create a Azure KeyVault.

|S. No|	Parameter Name|Description|Mandatory/Optional|
|---|------------------|------------------------------------|---------------------------------|
|1|keyvault_name|Specifies the name of the Key Vault.|Mandatory| 
|1|resourcegroup_name|The name of the resource group in which to create the Key Vault|Mandatory| 
|2|location|Specifies the supported Azure location where the resource exists|Mandatory| 
|3|sku_name| The Name of the SKU used for this Key Vault. Possible values are standard and premium.|Optional| 
|4|tenant_id|The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault.|Mandatory|
|5|access_policy|A list of up to 16 objects describing access policies, as described below.|Optional|
|6|enabled_for_disk_encryption|Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false.|Optional|
|7|enabled_for_deployment|Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false.|Optional|
|8|enabled_for_template_deployment|Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false.|Optional|
|9|enable_rbac_authorization| Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false.|Mandatory|
|10|purge_protection_enabled|Purge Protection enabled for this Key Vault? Defaults to false.|Optinal|
|11|soft_delete_retention_days|The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days.|Optional|
|12|create_resource_group||Optional|
|13|object_id|The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies.|Mandatory|
|14|ip_rules|One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.|Optional|
|15|virtual_network_subnet_ids|One or more Subnet ID's which should be able to access this Key Vault.|Optional|
|16|key_permissions|List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey.|Optinal|
|17|secret_permissions|List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set.|Optional|
|18|storage_permissions||Mandatory|
|19|create_keyvault_secret|Used when creating the Key Vault Secret.|Mandatory|
|20|create_private_endpoint||Mandatory|
|21|subnet_name||Mandatory|
|22|virtual_network_name||Mandatory|
|23|vnet_resource_group_name||Mandatory|
|24|bypass||Mandatory|
|25|secret_list||Mandatory|
|26|default_action||Mandatory|





<!-- END_TF_DOCS -->

## Related documentation

Microsoft Azure documentation:https://docs.microsoft.com/en-us/azure/key-vault/

Terraform Documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault


