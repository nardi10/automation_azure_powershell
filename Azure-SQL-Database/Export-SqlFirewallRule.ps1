Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

$SubscriptionName = set-AzContext -SubscriptionName $Sub
$SubscriptionName.Subscription

    $server = Get-AzSqlServer

    foreach ( $azserver in $server ) {
    
        $rule = Get-AzSqlServerFirewallRule -ServerName $azserver.servername -ResourceGroupName $azserver.ResourceGroupName

        foreach ($azrule in $rule) {
        $info = $azrule.ResourceGroupName + ";" + $azrule.ServerName + ";" + $azrule.StartIpAddress + ";" + $azrule.EndIpAddress + ";" + $azrule.FirewallRuleName
        $info | Out-file "C:\Rule_Allow_DB_NEW_2024.csv" -Append

        }

    }