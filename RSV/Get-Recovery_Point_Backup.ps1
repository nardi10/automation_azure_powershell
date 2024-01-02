Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

$vault = Get-AzRecoveryServicesVault
$startDate = (Get-Date).AddDays(-2190)
$endDate = Get-Date


foreach ( $azvault in $vault ) {
    $container = Get-AzRecoveryServicesBackupContainer -ContainerType "AzureVM" -Status "Registered" -VaultId $azvault.ID
    foreach ( $azcontainer in $container) {
        $backupItem = Get-AzRecoveryServicesBackupItem -Container $azcontainer -WorkloadType AzureVM -VaultId $azvault.ID
        foreach ( $azbackupItem in $backupItem) {
            $rp = Get-AzRecoveryServicesBackupRecoveryPoint -Item $azbackupItem -StartDate $startdate.ToUniversalTime() -EndDate $enddate.ToUniversalTime() -VaultId $azvault.ID 
            foreach ($azrp in $rp) { 
                    $info = $azvault.Name + ";" + $azvault.ResourceGroupName + ";" + $azvault.Location + ";" + $azcontainer.FriendlyName + ";" + $azrp.recoverypointtype + ";" + $azrp.RecoveryPointTime + ";" + $azbackupItem.ProtectionPolicyName
                    $info | Out-file "C:\Recovery_points.csv" -Append
                    $info
            }
        }
    }
}



