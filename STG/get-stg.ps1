
$subs = @("YOUR-SUBSCRIPTIONS")


$stglist = get-content("C:\path\file-name.txt")

foreach ($rg in $stglist) {
    $storages = Get-AzStorageAccount -ResourceGroupName $rg
    foreach ($s in $storages) {
        $rule = Get-AzStorageAccountNetworkRuleSet -ResourceGroupName $s.ResourceGroupName -Name $s.StorageAccountName
        foreach($ip in $rule.IpRules ) {
            $ips += $ip.ipAddressorRange + ","
        }
        $info = $s.StorageAccountName + ";" + $s.ResourceGroupName + ";" + $rule.DefaultAction + ";" + $ips
        $info | Out-File "C:\path\storageAccounts.csv" -Append
        $ips = ''
    }

}