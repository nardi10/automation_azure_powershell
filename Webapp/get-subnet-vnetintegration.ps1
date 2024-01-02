

$webapp = Get-AzWebApp
foreach ($azwebapp in $webapp) {
    $azplan = Get-AzResource -ResourceId $azwebapp.ServerFarmId
    $webapp
    $webAppConfig = Get-AzResource -ResourceName "$($azwebapp.Name)/web" -ResourceType "Microsoft.Web/sites/config" -ApiVersion 2015-08-01 -ResourceGroupName $azwebapp.ResourceGroup
    $webAppConfig
    $currentVnet = $webAppConfig.Properties.VnetName
    $currentVnet
    #$farm = $webapp.ServerFarmId.Split("/")
    $info =  $azwebapp.Name + ";" + $azplan.Name  + ";" + $azplan.sku.size + ";" + $azplan.sku.tier + ";" + $azwebapp.ResourceGroup + ";" + $azwebapp.Kind + ";" + $currentVnet
    $info | Out-File "C:\Temp\AppServices-DEV.CSV" -Append
}

