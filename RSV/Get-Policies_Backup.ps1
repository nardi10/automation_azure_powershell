Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

$vault = Get-AzRecoveryServicesVault

foreach ( $azvault in $vault ) {
    $container = Get-AzRecoveryServicesBackupContainer -ContainerType "AzureVM" -Status "Registered" -VaultId $azvault.ID
    foreach ( $azcontainer in $container) {
        $backupItem = Get-AzRecoveryServicesBackupItem -Container $azcontainer -WorkloadType AzureVM -VaultId $azvault.ID
        foreach ( $azbackupItem in $backupItem) {
            $info = $azvault.Name + ";" + $azvault.ResourceGroupName + ";" + $azcontainer.FriendlyName + ";" + $azvault.Location + ";" + $azbackupItem.ProtectionPolicyName
            $info | Out-file "C:\Policy_Servers.csv" -Append
            $info

            }

    }


}







