Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

$asp  = Get-AzAppServicePlan

    foreach ($azasp in $asp) {
    $ASPScale = Get-AzAutoscaleSetting -Name $azasp.Name -ResourceGroupName $azasp.ResourceGroup
        $info = $azasp.Name + ";" + $azasp.MaximumElasticWorkerCount + ";" + $ASPScale.Enabled + ";" + $azasp.Location + ";" + $azasp.ResourceGroup + ";" + $azasp.Sku.Tier + ";" + $azasp.NumberOfSites
        $info | Out-file "C:\Temp\aspgeral_prd.csv" -Append

    }


