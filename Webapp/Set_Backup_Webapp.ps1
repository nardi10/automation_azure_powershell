Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

#$webappname = get-content("C:\webapp.txt")
$webapp = Get-AzWebApp
$contador = 1


foreach ($azwebapp in $webapp) {
        $azplan = Get-AzResource -ResourceId $azwebapp.ServerFarmId
        if ((($azplan.sku.Tier -eq "Standard") -or ($azplan.sku.Tier -eq "Premium") -or ($azplan.sku.Tier -eq "PremiumV2") -or ($azplan.sku.Tier -eq "Isolated"))) {
        #$wbappsreplstring = ($azwebappname.Replace("-", "").Substring($azwebappname.Length -10, 10))
        #$storagename = "stg$wbappsreplstring"
        #$storagename = "stgbkpprd$(Get-Random -Minimum 1 -Maximum 4)"
        $storagename = "stgbkpprd$contador"
        $container = "backupplicacao"
        $backupname="backupApp"
        $storage = New-AzStorageAccount -ResourceGroupName $azwebapp.ResourceGroup -Name $storagename -SkuName Standard_LRS -Location eastus
        $contador++
        New-AzStorageContainer -Name $container -Context $storage.Context
        $sasUrl = New-AzStorageContainerSASToken -Name $container -Permission rwdl -Context $storage.Context -ExpiryTime (Get-Date).AddYears(100) -FullUri
        #New-AzWebAppBackup -ResourceGroupName $azwebapp.ResourceGroup -Name $azwebappname -StorageAccountUrl $sasUrl -BackupName $backupname
        $confibackup = Edit-AzWebAppBackupConfiguration -ResourceGroupName $azwebapp.ResourceGroup -Name $azwebapp.Name -StorageAccountUrl $sasUrl -FrequencyInterval 1 -FrequencyUnit Day -KeepAtLeastOneBackup -StartTime 14:00 -RetentionPeriodInDays 7
        $confibackup
        # List statuses of all backups that are complete or currently executing.
        # Get-AzWebAppBackupList -ResourceGroupName $azwebapp.ResourceGroup -Name $azwebappname

        }
}
   





























Get-Random -Minimum 1 -Maximum 10
$contador = 0

while($true){
    $contador++
    $contador
    if ($contador -ge 0) {break}

}
