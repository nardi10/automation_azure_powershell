
Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

$conn = Get-AzVirtualNetworkGatewayConnection -Name YOUR-CONNECTION-NAME -ResourceGroupName YOUR-RG-OF_CONNECTION

 
Set-AzVirtualNetworkGatewayConnection -VirtualNetworkGatewayConnection $conn -verbose -debug