Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

Get-AzRoleDefinition -Name "DeveloperProfile01" | ConvertTo-Json | Out-File "C:\role.json"