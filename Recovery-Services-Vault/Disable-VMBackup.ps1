

Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

$vault = Get-AzRecoveryServicesVault -ResourceGroupName YOUR-RESOURCE-GROUP-NAME -Name YOUR-RSV-NAME

foreach ( $azvault in $vault ) {
$container = Get-AzRecoveryServicesBackupContainer -ContainerType "AzureVM" -Status "Registered" -VaultId $azvault.ID
    foreach ( $azcontainer in $container) {
    $backupItem = Get-AzRecoveryServicesBackupItem -Container $azcontainer -WorkloadType AzureVM -VaultId $vault.ID
        foreach ( $azbackupItem in $backupItem) {
        Set-AzRecoveryServicesVaultContext -Vault $azvault
        Disable-AzRecoveryServicesBackupProtection -Item $azbackupItem -Force
        $azbackupItem
        }
    }
}
