Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

$asps  = Get-AzAppServicePlan | Where {($_.Sku.Tier -eq "Standard") -or ($_.Sku.Tier -eq "Premium") -or ($_.Sku.Tier -eq "PremiumV2")}
$counter = 1

foreach ($azasps in $asps) {
        $webapp = Get-AzWebApp -AppServicePlan $azasps
        $webapp
        $storagename = "stgbkpqadev$counter" 
        #$container = "appbackup$counter"
        $backupname="backupApp"
        $storage = New-AzStorageAccount -ResourceGroupName $azasps.ResourceGroup -Name $storagename -SkuName Standard_LRS -Location $azasps.Location
        $counter++
        foreach ($azwebapp in $webapp){  
            New-AzStorageContainer -Name $azwebapp.Name.ToLower() -Context $storage.Context
            $sasUrl = New-AzStorageContainerSASToken -Name $azwebapp.Name.ToLower() -Permission rwdl -Context $storage.Context -ExpiryTime (Get-Date).AddYears(100) -FullUri          
            $confibackup = Edit-AzWebAppBackupConfiguration -ResourceGroupName $azwebapp.ResourceGroup -Name $azwebapp.Name -StorageAccountUrl $sasUrl -FrequencyInterval 1 -FrequencyUnit Day -KeepAtLeastOneBackup -StartTime 14:00 -RetentionPeriodInDays 7
            $confibackup

            }   

}
