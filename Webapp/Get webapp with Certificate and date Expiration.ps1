Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION
$webapp = Get-AzWebApp

foreach ($azwebapp in $webapp ) {
$webappcert = Get-AzWebAppCertificate -ResourceGroupName $azwebapp.ResourceGroup
        foreach ($azwebappcert in $webappcert) {
        $info = $azwebapp.Name + ";" + $azwebapp.ResourceGroup + ";" + $azwebapp.HostNames + ";" + $azwebappcert.ExpirationDate
        $info | Out-file "C:\infowebapp_datadrivendev" -Append
        $info
        }
}
