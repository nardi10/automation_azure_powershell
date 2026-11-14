# SQL Server on VM (SQL IaaS)

Scripts for **SQL Server running on Virtual Machines**.

| Script | Description |
|--------|-------------|
| `Get-SqlVMRecoveryPoint.ps1` | Lists the *recovery points* of MSSQL databases on protected VMs (workload backup). |
| `Get-SqlVMRecoveryPointDetailed.ps1` | Variant with detail per item/VM and *recovery point* type. |
| `Install-SqlVMAgent.ps1` | Registers the **SQL IaaS Agent Extension** (*Full* mode) on VMs and converts them to SQL VM (`New-AzSqlVM` / `Update-AzSqlVM`). |

> Prerequisites: **Az** module and `Connect-AzAccount`.
