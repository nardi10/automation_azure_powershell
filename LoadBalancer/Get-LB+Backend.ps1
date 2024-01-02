Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION
$lb = Get-AzLoadBalancer

foreach ($azlb in $lb) {
$be = Get-AzLoadBalancerBackendAddressPool -ResourceGroupName $azlb.ResourceGroupName -LoadBalancerName $azlb.Name
    foreach ($azbe in $be) {
    $info = $azlb.name + ";" + $azlb.location + ";" + $azbe.BackendIpConfigurations.id
    $info | Out-file "C:\Temp\FILE-NAME.csv" -Append

    }
    
}