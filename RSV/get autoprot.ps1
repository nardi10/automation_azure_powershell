
$Vault = Get-AzRecoveryServicesVault

foreach ( $azvault in $vault ) {
$Container = Get-AzRecoveryServicesBackupContainer -ContainerType AzureVMAppContainer -VaultId $azVault.Id
    foreach ( $azContainer in $Container ) {
    $protec = Get-AzRecoveryServicesBackupProtectableItem -Container $azContainer -ItemType "SQLInstance" -WorkloadType "MSSQL" -VaultId $azVault.ID
        if ( ($protec.IsAutoProtectable -eq $true) -or ($protec.IsAutoProtectable -eq $false)) {
            $info = $azvault.Name + ";" + $protec.ServerName + ";" + $protec.IsAutoProtected
            $info | Out-file "C:\autoprot-prd4.csv" -Append
            $info

        }
    }
}
 

