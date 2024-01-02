

Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

$resourceGroups = Get-AzResourceGroup
foreach ($rgs in $resourceGroups) {
    $resourceCount = (Get-AzResource -ResourceGroupName $rgs.ResourceGroupName).Count
        $info = $rgs.ResourceGroupName + ";" + $resourceCount
        $info | Out-File "C:\temp\FILE-NAME.csv" -Append
        $info      
        }

