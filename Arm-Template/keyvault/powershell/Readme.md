# Azure Key Vault Creation
This folder provides guidance on the creating Azure Key Vault and associate Vnet/Subnet to the created key vault using Powershell.



```
az network vnet subnet update \ 
  --name mySubnet \ 
  --resource-group myResourceGroup \ 
  --vnet-name myVirtualNetwork \ 
  --disable-private-endpoint-network-policies true
  
```

## Inputs
Fill following inputs in **inputs_keyvault.yml** to create Azure Key Vault.
|S.No|Parameter Name|Description|Allowed Values|Mandatory/ Optional|
|----|--------------|---------|-----|-----|
|1|deploymentName|Provide a relevant name for the deployment|Any valid name|mandatory|
|2|subscription|Subscription in which Azure Key Vault will be deployed|Any subscription id|mandatory|
|3|Location|Location in which Azure Key Vault will be deployed|North Europe, West Europe|mandatory|
|4|resourceGroup|Resource group in which Azure Key Vault will be deployed|Any resource group|mandatory|
|5|otherUserSecurityGroupName|Provide team AD group who would require access to the keyvault|AD group ID|mandatory|
|6|privateLinkVNet|VNET that should be associated with the keyvault|Valid Vnet ID|mandatory|
|7|privateLinkVNetResourceGroup|Resource group of VNET that will be associated with the keyvault|VNET's resource group.|mandatory|
|8|privateLinkSubnet|Subnet that will be associated with the key vault|Subnet name|mandatory|
|9|endPoint|Microsoft.KeyVault|Do not change|mandatory|
|10|Owner|Tag that will be assigned to the keyvault|Any valid tag name for "owner"|mandatory|
|11|CreatedBy|Tag that will be assigned to the keyvault|Any valid tag name for "CreatedBy"|mandatory|
|12|keyVaultName|Provide a name for the keyvault that will be deployed|Any valid keyvault name|mandatory|
|13|sku|Required SKU for creating keyvault|Standard, Premium|mandatory|
|14|tenant|The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault|Valid tenant ID|mandatory|
|15|enabledForDeployment|Property to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault|true, false|mandatory|
|16|enabledForTemplateDeployment|Property to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault|true, false|mandatory|
|17|enabledForDiskEncryption|Property to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys|true,  false|mandatory|
|18|enableRbacAuthorization|	Property that controls how data actions are authorized. When true, the key vault will use Role Based Access Control (RBAC) for authorization of data actions. When false, the key vault will use the access policies specified in vault properties, and any policy stored on Azure Resource Manager will be ignored. If null or not specified, the vault is created with the default value of false. Note that management actions are always authorized with RBAC|true, false|mandatory|
|19|enableSoftDelete|Property to specify whether the 'soft delete' functionality is enabled for this key vault|true, false |mandatory|
|20|softDeleteRetentionInDays|softDelete data retention days.|It accepts >=7 and <=90|mandatory|
|21|enablePurgeProtection|Property specifying whether protection against purge is enabled for this vault. Setting this property to true activates protection against purge for this vault and its content - only the Key Vault service may initiate a hard, irrecoverable deletion. The setting is effective only if soft delete is also enabled. Enabling this functionality is irreversible - that is, the property does not accept false as its value.|true, false|mandatory|


## Steps to follow
- Prepare pre-requisites.
- Clone *** Repo.
- Prepare inputs to create Azure Key Vault.
- Execute **wrapper_script_keyvault.ps1** like below,
```powershell
[string[]]$fileContent = Get-Content "*inputs_keyvault.yml"
$content = ''
foreach ($line in $fileContent) { $content = $content + "`n" + $line }
$yaml = ConvertFrom-YAML $content
*wrapper_script_keyvault.ps1 -deploymentName $yaml.variables.deploymentName -subscription $yaml.variables.subscription -Location $yaml.variables.Location -resourceGroup $yaml.variables.resourceGroup -otherUserSecurityGroupName $yaml.variables.otherUserSecurityGroupName -privateLinkVNet $yaml.variables.vnetName -privateLinkVNetResourceGroup $yaml.variables.vnetRG -privateLinkSubnet $yaml.variables.subnetName -endPoint $yaml.variables.endPoint -Owner $yaml.variables.Owner -CreatedBy $yaml.variables.CreatedBy -keyVaultName $yaml.variables.keyVaultName -sku $yaml.variables.sku -tenant $yaml.variables.tenant -enabledForDeployment $yaml.variables.enabledForDeployment -enabledForTemplateDeployment $yaml.variables.enabledForTemplateDeployment -enabledForDiskEncryption $yaml.variables.enabledForDiskEncryption -enableRbacAuthorization $yaml.variables.enableRbacAuthorization -enableSoftDelete $yaml.variables.enableSoftDelete -softDeleteRetentionInDays $yaml.variables.softDeleteRetentionInDays -enablePurgeProtection $yaml.variables.enablePurgeProtection
 ```
