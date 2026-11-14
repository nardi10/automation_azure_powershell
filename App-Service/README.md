# App Service / Web Apps

Scripts for inventory, backup, and configuration of **Web Apps and App Service Plans**.

| Script | Description |
|--------|-------------|
| `Get-WebAppReport.ps1` | Web apps report (state, plan, SKU/size, tier). |
| `Get-AppServicePlanReport.ps1` | **App Service Plans** report (autoscale, tier, worker count, number of sites). |
| `Get-WebAppBackupReport.ps1` | Report of web apps + plan + backup configuration (enabled, retention, frequency, storage URL). |
| `Get-WebAppCertificateExpiration.ps1` | Lists web apps with their certificates and **expiration date**. |
| `Get-WebAppAccessRestriction.ps1` | Exports the *access restrictions* (IP rules) of the web apps listed in a file. |
| `Get-WebAppSlot.ps1` | Lists the *deployment slots* of each web app. |
| `Get-WebAppTag.ps1` | Extracts the *tags* of web apps (Application, BusinessUnit, Provider, Environment, Owner, etc.). |
| `Set-WebAppBackup.ps1` | Creates storage + container + SAS and configures **daily backup** on web apps of Standard/Premium/Isolated tiers. |
| `Set-WebAppBackupByServicePlan.ps1` | Variant of the above that iterates by **App Service Plan**. |
| `Get-WebAppVNetIntegration.ps1` | Lists the **VNet integration** (VnetName) of web apps — DEV output. |
| `Get-WebAppVNetIntegrationV2.ps1` | Same as above — PRD output. |
| `Get-WebAppVNetIntegrationCli.ps1` | Uses the **Azure CLI** (`az`) to list VNet integration of web apps and function apps. |
| `Get-FolderSize.ps1` | Local (non-Azure) *helper*: calculates the size of folders under `C:\Users`. |

> Prerequisites: **Az** module and `Connect-AzAccount`; `Get-WebAppVNetIntegrationCli.ps1` requires the **Azure CLI**.
