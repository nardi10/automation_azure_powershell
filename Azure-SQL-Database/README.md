# Azure SQL (PaaS)

Scripts for **Azure SQL Database / SQL Server (PaaS)**.

| Script | Description |
|--------|-------------|
| `Export-SqlFirewallRule.ps1` | Exports the firewall rules (allowed IPs) of SQL Servers to CSV. |
| `Export-SqlFirewallRuleV2.ps1` | Version 2: iterates over **multiple subscriptions** (by ID), skips the `0.0.0.0` rule (AllowAllAzure), and handles errors per server. |
| `Get-SqlBackupRetention.ps1` | Exports backup retention policies (short- and long-term) and the storage redundancy of the databases. |
| `Get-SqlAadAdmin.ps1` | Lists the **Azure AD administrator** configured on each SQL Server. |

> Prerequisites: **Az** module and `Connect-AzAccount`.
