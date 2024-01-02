Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION-ID

New-AzRoleDefinition -InputFile "C:\Temp\teste01.json"


#teste01.json
{
"Name": "Virtual Machine Reader",
"IsCustom": true,
"Description": "Can deallocate, start and restart virtual machines.",
"Actions": [
"Microsoft.Compute/availabilitySets/*/read",
"Microsoft.Compute/locations/*/read",
"Microsoft.Compute/virtualMachines/*/read",
"Microsoft.Compute/virtualMachineScaleSets/*/read",
"Microsoft.Network/locations/*/read",
"Microsoft.Network/networkInterfaces/*/read",
"Microsoft.Network/virtualNetworks/read",
"Microsoft.ResourceHealth/availabilityStatuses/read",
"Microsoft.Resources/deployments/*/read",
"Microsoft.Resources/subscriptions/resourceGroups/read",
"Microsoft.SqlVirtualMachine/*",
"Microsoft.Insights/ActivityLogAlerts/*",
"Microsoft.Insights/Logs/AzureActivity/Read"



],
"NotActions": [



],
"AssignableScopes": [
"/subscriptions/YOUR-SUBSCRIPTION-ID"
]
}