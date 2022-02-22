[CmdletBinding()]
param (
    $deploymentName,$subscription,$Location,$resourceGroup,$otherUserSecurityGroupName,$privateLinkVNet,$privateLinkVNetResourceGroup,$privateLinkSubnet,$endPoint,$Owner,$CreatedBy,$keyVaultName,$sku,$tenant,$enabledForDeployment,$enabledForTemplateDeployment,$enabledForDiskEncryption,$enableRbacAuthorization,$enableSoftDelete,$softDeleteRetentionInDays,$enablePurgeProtection
)

try{
$networkAcls = @{ "defaultAction"= "allow";"bypass"= "AzureServices";"ipRules"= @();"virtualNetworkRules"= @()}
$scriptParams = @{"deploymentName" = $deploymentName; "templateFile" = "MyCloud/Arm-Template/keyvault/keyvault_creation.json"; "otherUserSecurityGroupName" = $otherUserSecurityGroupName; "endPoint"=$endPoint; "templateParams"= @{"tags" = @{"Owner"= $Owner;"CreatedBy"= $CreatedBy}; "keyVaultName" = $keyVaultName; "sku" = $sku; "tenant" = $tenant; "enabledForDeployment" = [System.Convert]::ToBoolean($enabledForDeployment); "enabledForTemplateDeployment" = [System.Convert]::ToBoolean($enabledForTemplateDeployment); "enabledForDiskEncryption" = [System.Convert]::ToBoolean($enabledForDiskEncryption); "enableRbacAuthorization" = [System.Convert]::ToBoolean($enableRbacAuthorization); "enableSoftDelete" = [System.Convert]::ToBoolean($enableSoftDelete); "softDeleteRetentionInDays" = [int]$softDeleteRetentionInDays; "enablePurgeProtection" = [System.Convert]::ToBoolean($enablePurgeProtection); "networkAcls" = $networkAcls;"privateLinkVNet" = $privateLinkVNet;"privateLinkVNetResourceGroup" = $privateLinkVNetResourceGroup; "privateLinkSubnet" = $privateLinkSubnet;"subscription" = $subscription;"resourceGroup" = $resourceGroup;"location" = $Location}}

$scriptParams
$scriptParams.ForEach({
if ($null -ne $_ -and 'Hashtable' -eq $_.getType().Name) {
if ($_.ContainsKey("DeploymentName") -and $_.ContainsKey("Outputs") -and $_.ContainsKey("Provisioningstate")) {
$delpoymentStatus = $_ | ConvertTo-Json
Write-Output 'Job Output is :'$delpoymentStatus
Write-Output 'provisioning state : '$_.Provisioningstate
if ($_.Provisioningstate -eq "Failed") {
throw $_ | ConvertTo-Json
}
}
}
})
}catch{
Write-Output "Error caught in Master Deployment Script:"
Write-Output $_
Write-Output $_.ErrorDetails
Write-Output $_.ScriptStackTrace
$host.SetShouldExit(-1)
}
