Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

$vault = Get-AzRecoveryServicesVault
$startDate = (Get-Date).AddDays(-2190)
$endDate = Get-Date


foreach ( $azvault in $vault ) {
    $SQLContainer = Get-AzRecoveryServicesBackupContainer -ContainerType AzureVMAppContainer -VaultId $azvault.ID
    foreach ( $azsqlcontainer in $SQLContainer) {
        foreach ($azvm in $azsqlcontainer) {
        $backupItemSQL = Get-AzRecoveryServicesBackupItem -BackupManagementType AzureWorkload -WorkloadType MSSQL -VaultId $azvault.ID
                foreach ($azsqlitem in $backupItemSQL) { 
                $rp = Get-AzRecoveryServicesBackupRecoveryPoint -Item $azsqlItem -StartDate $startdate.ToUniversalTime() -EndDate $enddate.ToUniversalTime() -VaultId $azvault.ID 
                    foreach ($azrp in $rp) {
                    $info = $azvault.Name + ";" + $azvault.ResourceGroupName + ";" + $azvault.Location + ";" + $azvm.Name + ";" + $azsqlitem.Name + ";" + $azrp.RecoveryPointTime + ";" + $azrp.RecoveryPointType
                    $info | Out-file "C:\VMSQL_DEV_QA.csv" -Append
                    $info
                    }
                
                
                }    
                
        }

    }
}


