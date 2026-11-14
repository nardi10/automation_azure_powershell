# Virtual Machines (VM)

Scripts for creating, migrating, and operating **Virtual Machines**.

| Script | Description |
|--------|-------------|
| `New-VMFromBlob.ps1` | Creates a VM from a VHD in blob (OS disk *attach*), configuring NIC and subnet. Uses **Az** cmdlets. |
| `New-VMFromBlobLegacy.ps1` | Same creation flow from a VHD, but with **AzureRM** cmdlets (legacy) — useful for region-migration scenarios. |
| `Set-VMPowerStateByTag.ps1` | *Runbook* (Azure Automation) that **starts/stops** VMs filtered by *tag*, based on the `-action start|stop` parameter, authenticating via a *RunAs connection* (service principal). |

> Prerequisites: **Az** module (and **AzureRM** for the legacy script); `Set-VMPowerStateByTag.ps1` is designed to run in Azure Automation.
