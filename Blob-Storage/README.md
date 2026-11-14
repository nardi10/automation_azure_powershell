# Blob Storage

Scripts for **Azure Blob Storage** operations.

| Script | Description |
|--------|-------------|
| `Copy-ManagedDiskToBlob.ps1` | Copies a *managed disk* to a blob (`.vhd`) in another storage account, using a temporary SAS (`Grant-AzDiskAccess`). |
| `Get-BlobVhdReport.ps1` | Iterates over all containers of a storage account and lists `.vhd` blobs with their size in GB, exporting to CSV. |
| `Restore-DeletedBlob.ps1` | Restores deleted blobs (*undelete*) within a container via a REST call with a *bearer token*, then removes them. **Modifies data — review before running.** |

> Prerequisites: **Az** module and `Connect-AzAccount`.
