# Storage Accounts (STG)

Scripts for **Storage Account** inventory and governance.

| Script | Description |
|--------|-------------|
| `Get-StorageNetworkRule.ps1` | Exports the *network rules* (allowed IPs and *default action*) of the storage accounts listed in a text file. |
| `Get-StorageServiceInventory.ps1` | Inventories the resources of each storage account — **Blob Containers, File Shares, Queues, and Tables** — across all subscriptions and generates a multi-sheet **Excel** report (including an *Error Log* sheet). |

> Prerequisites: **Az** module; the Excel inventory requires the **ImportExcel** module.
