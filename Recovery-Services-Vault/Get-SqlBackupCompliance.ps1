Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION


$Vault = Get-AzRecoveryServicesVault -Name YOUR-RSV-NAME

foreach ( $azvault in $vault ) {
$Container = Get-AzRecoveryServicesBackupContainer -ContainerType AzureVMAppContainer -Status Registered -VaultId $azVault.Id
$Container
    foreach ( $azContainer in $Container ) {
    $protec = Get-AzRecoveryServicesBackupProtectableItem -Container $azContainer -ItemType "SQLInstance" -WorkloadType "MSSQL" -VaultId $azVault.ID
    $protec
    $Item = Get-AzRecoveryServicesBackupItem -BackupManagementType AzureWorkload -WorkloadType MSSQL -VaultId $azvault.ID
    $Item
        foreach ( $azItem in $Item) {
        $policyName = Get-AzRecoveryServicesBackupProtectionPolicy -VaultId $azvault.ID -WorkloadType MSSQL
        $policyName
            foreach ( $azItem in $Item) {
            $info = $azvault.Name + ";" + $protec.ServerName + ";" + $protec.IsAutoProtected
            $info | Out-file "C:\FILE-NAME.csv" -Append
            $info
            }
        }
    }

}



















