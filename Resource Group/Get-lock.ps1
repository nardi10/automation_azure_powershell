Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

$rg = Get-AzResourceGroup

foreach ($azrg in $rg) {
$lock = Get-AzResourceLock -ResourceGroupName $azrg.ResourceGroupName
    foreach ($azlock in $lock) {
    $info = $azrg.ResourceGroupName + ";" + $azlock.Name
    $info | Out-file "C:\temp\lock_FILE.csv" -Append
    $info
    }
    
}

