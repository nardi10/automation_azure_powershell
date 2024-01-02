Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

# Get the Application Gateway we want to modify
$appgw = Get-AzApplicationGateway -Name YOUR-APPLICATION-GATEWAY -ResourceGroupName YOUR-RESOURCE-GROUPS

# Specify the resource id to the user assigned managed identity - This can be found by going to the properties of the managed identity
Set-AzApplicationGatewayIdentity -ApplicationGateway $appgw -UserAssignedIdentityId YOUR-MANAGED-IDENTITY

# Get the secret ID from Key Vault
$secret = Get-AzKeyVaultSecret -VaultName YOUR-KEYVAULT -Name YOUR-SECRET
$secretId = $secret.Id.Replace($secret.Version, "") # Remove the secret version so AppGW will use the latest version in future syncs
# Specify the secret ID from Key Vault 
Add-AzApplicationGatewaySslCertificate -KeyVaultSecretId $secretId -ApplicationGateway $appgw -Name $secret.Name
# Commit the changes to the Application Gateway
Set-AzApplicationGateway -ApplicationGateway $appgw

