# Application Gateway Creation with Keyvault Module Integration
This folder provides guidance on the creating Application Gateway in Azure.


## Overview 
Application gateway will be created as a front end to webapp. All communication to webapp will be passed through the application gateway.

## Pre-Requisites
#### Subscription and Resource Group
- Subscription should be available.
- Resource Group should be available in your Subscription.
#### Azure Resources
- One VNET available in same subscription / region of the application gateway is required.
- **One subnet which has no other services in it is required**
- Azure KeyVault should be available and also can be created using the module
#### SSL Certificate for APP Gateway
While creating APP gateway SSL certificate and its password is required. Certificate should be kept in a base64 format at keyvault and should be mentioned in the parameter file. Below command you can use to upload certificate to keyvault.
```cli
az keyvault secret set --vault-name KEY_VAULT_NAME --encoding base64 --description text/plain --name CERT_SECRET_NAME --file certificate.pfx
```

## Version compatibility

| Module version | Terraform version |
| -------------- | ----------------- |
| >= 1.0.0       | >= 1.0.11    |

## How to Consume

This module is optimized to work with the [Azurerum-Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs) tool
which set some terraform variables in the environment needed by this module. For advanced configuration refer the input section for parameter detail.

You can use this module by including it this way:

```hcl

module "App-Gateway"
{
  source                          = "https://github.com/venkat6597/MyCloud/tree/main/terraform-modules/"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  application_gateway_name        = "SampAppGateway"
  frontendIP_config_name          = var.frontendIP_config_name
  gateway_tier_name               = var.gateway_tier_name
  gateway_tier                    = var.gateway_tier
  backend_address_pool_list       = [{name  = "backpool",fqdns = ["samp"],ip_address = ["0.0.0.0"]}]
  backend_http_settings_list      = [{name = "backendsettingsname1",port = "00",protocol= "Https",request_timeout = "00",probe_name = ""}]
}

```

<!-- BEGIN_TF_DOCS -->

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 2.85.0 |

## Inputs
Fill following inputs in **terraform.tfvars** to create Application gateway and add it in Webapp backend.
|S.No|Parameter Name|Description|Allowed Values|Mandatory / Optional|
|----|--------------|---------|-----|-----|
|1|appgw_resource_group_name|Resource group in which webapp and Application gateway will be deployed|Any resource group|mandatory|
|2|enable_resource_group|'True' to create Resource or to use existing one |Any resource group|mandatory|
|3|rg-location |Location in which webapp and Application gateway will be deployed|North Europe, West Europe|mandatory|
|4|application_gateway_create|"true" to create application gateway else choose "false".||mandatory|
|5|ApplicationGateWayName|Name of application gateway.||mandatory|
|6|gateway_tier|Gateway tier with which application gateway should be created.|Standard, WAF|mandatory|
|7|gateway_tier_name|Gateway SKU s size.||mandatory|
|8|capacity|Instance count of application gateway.||mandatory|
|9|appgw_vnet_resource_group_name|Virtual network's resource group that should be used with application gateway.||mandatory|
|10|appgw_virtual_network_name|Virtual network that should be used with application gateway.||mandatory|
|11|gateway_subnet_name|Subnet that should be used with application gateway.||mandatory|
|11|FrontendIP_config_name |The Name of the Frontend IP Configuration used for this HTTP Listener.||mandatory|
|11|frontendPort_name|Frontend port name that should be used for HTTP / HTTPS.||mandatory|
|12|frontend_port|Frontend port that should be used for HTTP / HTTPS.||mandatory|
|13|frontend_protocol|Frontend protocol that should be used.||mandatory|
|14|backend_address_pool_name|The Name of the Backend Address Pool which should be used for this Routing Rule.||mandatory|
|15|backend_port|Backend port that should be used for HTTPS/HTTPS.|new, existing|mandatory|
|16|backend_http_settings_name|he Name of the Backend HTTP Settings Collection which should be used for this Routing Rule.||mandatory|
|17|backend_protocol|Backend protocol that should be used.||mandatory|
|18|private_ip_address_allocation| The The Allocation Method for the Private IP Address.Possible values are Dynamic and Static.||mandatory|
|19|static_private_ip| The Private IP Address to use for the Application Gateway.||mandatory|
|20|secret_certificate_data|sslCertificateData - Keyvault secret in which SSL certificate is kept.||mandatory|
|21|secret_certificate_password|sslCertificatePassword - Keyvault secret in which SSL certificate password is kept.||mandatory|

## Outputs

| Name | Description |
|------|-------------|
| appgw_id| The ID of the Application Gateway |
| appgw_backend_address_pool_ids | List of backend address pool Ids |
| appgw_backend_http_settings_ids | List of backend HTTP settings Ids |
| appgw_frontend_ip_configuration_ids | Frontend IP configuration Id |
| appgw_ssl_certificate_ids | SSL certificate Id |
<!-- END_TF_DOCS -->

## Related documentation

Terraform Documentation: [docs.terraform.com/en-us/azure/Application-Gateway/](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway)
