Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

$subs = @("YOUR ALL SUBSCRIPTION")

foreach ($sub in $subs) {
    $webapplist = get-content("C:\webapps\lista_app.txt")
    foreach ($azwebapplist in $webapplist) {
        $webapp = Get-AzWebApp -Name $azwebapplist
            $ar = Get-AzWebAppAccessRestrictionConfig -ResourceGroupName $webapp.ResourceGroup -Name $webapp.Name
            $mainsar = $ar.MainSiteAccessRestrictions
            foreach ($azmainsar in $mainsar) {
            $info = $webapp.name + ";" + $webapp.ResourceGroup + ";" + $azmainsar.RuleName + ";" + $azmainsar.Action + ";" + $azmainsar.IpAddress
            $info | Out-file "C:\webapps\YOUR-FILE.csv" -Append
            $info
            }
    }


}