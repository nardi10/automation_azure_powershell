Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

$vault = Get-AzRecoveryServicesVault

foreach ( $azvault in $vault ) {
$container = Get-AzRecoveryServicesBackupContainer -ContainerType "AzureVM" -Status "Registered" -VaultId $azvault.ID
$diag = Get-AzDiagnosticSetting $azvault.ID
    foreach ( $azcontainer in $container) {
    $backupItem = Get-AzRecoveryServicesBackupItem -Container $azcontainer -WorkloadType AzureVM -VaultId $azvault.ID
        foreach ( $azbackupItem in $backupItem) {
        $BackupStorageRedundancy = Get-AzRecoveryServicesBackupProperty -Vault $azvault
            foreach ( $azBackupStorageRedundancy in $BackupStorageRedundancy ) {
             $info = $azvault.Name + ";" + $azvault.ResourceGroupName + ";" + $azvault.Location + ";" + $azcontainer.FriendlyName + ";" + $azBackupStorageRedundancy.BackupStorageRedundancy + ";" +  $azbackupItem.PolicyId + ";" + $azbackupItem.LastBackupStatus + ";" + $diag.WorkspaceId
             $info | Out-file "C:\InfoGeral_VM_DATAPRD.csv" -Append
             $info
            }
         }
    }
}

$vault = Get-AzRecoveryServicesVault

foreach ( $azvault in $vault ) {
$container = Get-AzRecoveryServicesBackupContainer -ContainerType "AzureVM" -Status "Registered" -VaultId $azvault.ID
$diag = Get-AzDiagnosticSetting $azvault.ID
    foreach ( $azcontainer in $container) {
    $backupItem = Get-AzRecoveryServicesBackupItem -Container $azcontainer -WorkloadType AzureVM -VaultId $azvault.ID
        foreach ( $azbackupItem in $backupItem) {
        $BackupStorageRedundancy = Get-AzRecoveryServicesBackupProperty -Vault $azvault
             $info = $azvault.Name + ";" + $azvault.ResourceGroupName + ";" + $azvault.Location + ";" + $azcontainer.FriendlyName + ";" + $BackupStorageRedundancy.BackupStorageRedundancy + ";" +  $azbackupItem.PolicyId + ";" + $azbackupItem.LastBackupStatus + ";" + $diag.WorkspaceId
             $info | Out-file "C:\InfoGeral_VM_PRD.csv" -Append
             $info
            }
         }
    }






