Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

$webapp = Get-AzWebApp

foreach ($azwebapp in $webapp) {
    $azplan = Get-AzResource -ResourceId $azwebapp.ServerFarmId
    $info = $azwebapp.Name + ";" + $azwebapp.state + ";" + $azplan.Name + ";" + $azplan.sku.Size + ";" + $azplan.sku.tier
    $info | Out-file "C:\Temp\webapp_dev.csv" -Append
    $info
}


