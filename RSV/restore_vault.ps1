Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION


#Criação dos Container
$servers = get-content("C:\servers.txt")
$stContext = New-AzStorageContext -StorageAccountName 'YOUR-STORAGE-ACCOUNT-NAME' -StorageAccountKey 'YOUR-ACCESS-KEY'

foreach ($azservers in $servers) {
    $containerName = $azservers.ToLower()+($rp.recoverypointTime[0].ToString("ddMMyyyy"))
    $containerName
    New-AzStorageContainer -Context $stContext -Name $containerName
    #Faz a restauração
    $vault = Get-AzRecoveryServicesVault -ResourceGroupName YOUR-RG-RSV -Name YOUR-RSV-NAME
    $vault
    $BackupItem = Get-AzRecoveryServicesBackupItem -Name $azservers -BackupManagementType "AzureVM" -WorkloadType "AzureVM" -VaultId $vault.ID
    $BackupItem
    ##$RG = $BackupItem.name.Split(";")
    ##$RG = $RG[2]
    $StartDate = (Get-Date).Addyears(-4)
    $EndDate = Get-Date
    $rp = Get-AzRecoveryServicesBackupRecoveryPoint -Item $BackupItem -StartDate $StartDate.ToUniversalTime() -EndDate $EndDate.ToUniversalTime() -VaultId $vault.ID
    $rp
    $restoreDiskLUNs = ("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" )
    $RestoreJob = Restore-AzRecoveryServicesBackupItem -RecoveryPoint $RP[0] -TargetResourceGroupName "YOUR-RG-NAME-DEST" -StorageAccountName "YOUR-STG-NAME" -StorageAccountResourceGroupName "YOUR-RG-NAME-STORAGEACCOUNT" -RestoreDiskList $restoreDiskLUNs -VaultId $vault.ID -VaultLocation $vault.Location
    $RestoreJob
    #Realiza a copia
        While($true) {
        Start-Sleep -Seconds 60
            if ((Get-AzRecoveryServicesBackupJobDetail -VaultId $vault.ID -JobId $RestoreJob.jobid).Status -eq "Completed") {
            Break
            }
        }
  $containerdefault = Get-AzStorageContainer -Context $stContext | Where {$_.name -like $azservers+"-*"}
  $containerdefault
  Get-AzStorageBlob -Context $stContext -Container $containerdefault.Name | Start-AzStorageBlobCopy -DestContainer $containerName
}


