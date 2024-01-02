Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION


$server = Get-AzSqlServer

foreach ( $azserver in $server ) {
$database = Get-AzSqlDatabase -ServerName $azserver.ServerName -ResourceGroupName $azserver.ResourceGroupName
        foreach ($azdatabase in $database) {
        $retentionLong = Get-AzSqlDatabaseBackupLongTermRetentionPolicy -ServerName $azserver.ServerName -ResourceGroupName $azserver.ResourceGroupName -DatabaseName $azdatabase.DatabaseName
        $retentionShort = Get-AzSqlDatabaseBackupShortTermRetentionPolicy -ServerName $azserver.ServerName -ResourceGroupName $azserver.ResourceGroupName -DatabaseName $azdatabase.DatabaseName
        $info = $azdatabase.ServerName + ";" + $azdatabase.DatabaseName + ";" + $azdatabase.ResourceGroupName + ";" + $azdatabase.CurrentBackupStorageRedundancy + ";" + $retentionLong.WeeklyRetention + ";" + $retentionLong.MonthlyRetention + ";" + $retentionLong.YearlyRetention + ";" + $retentionLong.WeekOfYear + ";" + $retentionShort.RetentionDays
        $info | Out-file "C:\Report Backup PaaS\Backup_banco_dev.csv" -Append
        $info
        }
}

