Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

$plan = Get-AzAppServicePlan
$webapp = Get-AzWebApp



foreach ($azwebapp in $webapp) {
    $azplan = Get-AzResource -ResourceId $azwebapp.ServerFarmId
    $backupenable = Get-AzWebAppBackupConfiguration -ResourceGroupName $azwebapp.ResourceGroup -Name $azwebapp.Name
    $info = $azwebapp.Name + ";" + $azplan.Name + ";" + $azplan.sku.Size + ";" + $azplan.sku.tier
        foreach ($azbackupenable in $backupenable) {
            $info += ";" + $azbackupenable.Enabled + ";" + $azbackupenable.RetentionPeriodInDays + ";" + $azbackupenable.FrequencyInterval + ";" +  $azbackupenable.StorageAccountUrl
        }
    $info | Out-file "C:\Backup_webapp_prd.csv" -Append
    $info
}


