Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION


$AZVNETs = Get-AzVirtualNetwork

ForEach ($VNET in $AZVNETs) {
$subnet = Get-AzVirtualNetwork -Name $VNET.Name | Get-AzVirtualNetworkSubnetConfig
       foreach ($azsubnet in $subnet) {
       $info = $VNET.Name + ";" + $VNET.AddressSpace.AddressPrefixes + ";" + $azsubnet.Name + ";" + $azsubnet.AddressPrefix
       $info | Out-File "C:\SUBNET-DEV.csv" -Append
       $info
       }
}