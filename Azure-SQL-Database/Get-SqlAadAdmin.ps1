Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION


$Subs = @("SUBSCRIPTION-NAME")

foreach($Sub in $Subs) {
$SubscriptionName = Set-AzContext -SubscriptionName $Sub
$SubscriptionName.Subscription
    
    $sqlserver = Get-AzSqlServer

        foreach ($azsqlserver in $sqlserver) {
        $getsqlad = Get-AzSqlServerActiveDirectoryAdministrator -ServerName $azsqlserver.Servername -ResourceGroupName $azsqlserver.ResourceGroupName

            foreach ($azgetsqlad in $getsqlad) {
            $info = $getsqlad.ServerName + ";" + $getsqlad.DisplayName + ";" + $Sub
            $info | Out-file "c:\temp\FILE-NAME.csv" -Append
            $info
            }

        }

}


