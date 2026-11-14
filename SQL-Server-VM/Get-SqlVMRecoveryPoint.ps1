Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

$vault = Get-AzRecoveryServicesVault -ResourceGroupName YOUR-RG-NAME -Name YOUR-RSV-NAME

 
$startDate = (Get-Date).AddDays(-2190)
$endDate = Get-Date


foreach ( $azvault in $vault ) {
    $SQLContainer = Get-AzRecoveryServicesBackupContainer -ContainerType AzureVMAppContainer -VaultId $azvault.ID

    foreach ( $azsqlcontainer in $SQLContainer) {
        foreach ($azvm in $azsqlcontainer) {
        $backupItemSQL = Get-AzRecoveryServicesBackupItem -BackupManagementType AzureWorkload -WorkloadType MSSQL -VaultId $azvault.ID

        foreach ( $azbackupItem in $backupItem) {
            $rp = Get-AzRecoveryServicesBackupRecoveryPoint -Item $azbackupItem -StartDate $startdate.ToUniversalTime() -EndDate $enddate.ToUniversalTime() -VaultId $azvault.ID 
            foreach ($azrp in $rp) { 
                    $info = $azvault.Name + ";" + $azvault.ResourceGroupName + ";" + $azvault.Location + ";" + $azcontainer.FriendlyName + ";" + $azrp.RecoveryPointTime
                    $info | Out-file "C:\Recovery_points_VMSQL.csv" -Append
                    $info
            }
        }
    }

 }

}


