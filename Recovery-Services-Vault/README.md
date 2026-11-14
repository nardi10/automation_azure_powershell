# Recovery Services Vault (RSV)

Scripts for **backup and restore** with Azure Recovery Services Vault (VMs and SQL).

| Script | Description |
|--------|-------------|
| `Get-VaultBackupReport.ps1` | General vault report: storage redundancy, policy, last backup status, and diagnostics workspace (CSV). |
| `Get-VMBackupPolicy.ps1` | Lists the backup policy associated with each protected VM. |
| `Get-VMRecoveryPoint.ps1` | Lists the *recovery points* of protected VMs (~6-year window). |
| `Get-SqlBackupCompliance.ps1` | Checks backup *compliance* of protected SQL instances (`SQLInstance`/MSSQL) in the vaults. |
| `Get-SqlAutoProtection.ps1` | Checks the auto-protection state (`IsAutoProtected`) of SQL instances in the vaults. |
| `Disable-VMBackup.ps1` | **Disables** backup protection for the VMs of a vault (`-Force`). ⚠️ Destructive operation — review first. |
| `Restore-VMFromVault.ps1` | Restores VMs from *recovery points* to storage/disks and copies the blobs to named containers. ⚠️ Sensitive operation. |

> Prerequisites: **Az** module and `Connect-AzAccount`.
