# Automation Azure PowerShell

A collection of PowerShell scripts for **administration, inventory, and automation** of **Microsoft Azure** resources, organized by service. These are day-to-day cloud operations utilities: information gathering (CSV/Excel reports), backup, migration, access governance, and resource configuration.

> ⚠️ **Important — sensitive data**
> All scripts use **placeholders** instead of real values (IDs, resource names, keys).
> Before running, replace the `YOUR-*` values with your own environment's data.
> **Never** commit subscription IDs, tenant IDs, storage keys, SAS tokens, or real resource names.

## Prerequisites

- **PowerShell** 5.1+ or **PowerShell 7+**
- **Az** module — `Install-Module -Name Az`
- For the Excel reports (`Export-AzureResourceBaseline.ps1`, `Storage-Account/Get-StorageServiceInventory.ps1`): the **ImportExcel** module — `Install-Module -Name ImportExcel`
- Some scripts use the **AzureAD** module (`Connect-AzureAD`) and one uses the **Azure CLI** (`az`)
- Authentication: most scripts start with `Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION`

## How to use

1. Clone the repository.
2. Open the desired script and replace the `YOUR-*` placeholders with your environment's values.
3. Authenticate to Azure (`Connect-AzAccount`).
4. Run the script in PowerShell.
5. Many scripts write their output to CSV/Excel files — adjust the output path (e.g., `C:\Temp\...`) as needed.

## Repository structure

| Folder | Contents |
|--------|----------|
| [Application-Gateway](Application-Gateway/) | Application Gateway: certificates and Key Vault integration |
| [Azure-AD](Azure-AD/) | Azure AD / Entra ID: groups, roles, and role assignments |
| [Blob-Storage](Blob-Storage/) | Azure Blob Storage: disk copy, validation, and blob restore |
| [Managed-Disks](Managed-Disks/) | Managed Disks: VHD download |
| [Function-App](Function-App/) | Azure Functions: code deployment and tier change |
| [Load-Balancer](Load-Balancer/) | Load Balancer: backend pools |
| [Network-Security-Group](Network-Security-Group/) | Network Security Groups: rule export |
| [Public-IP](Public-IP/) | Public IPs: inventory |
| [Resource-Group](Resource-Group/) | Resource Groups: resource count and locks |
| [Recovery-Services-Vault](Recovery-Services-Vault/) | Recovery Services Vault: backup, policies, restore, and compliance |
| [Azure-SQL-Database](Azure-SQL-Database/) | Azure SQL (PaaS): firewall, backup, and AAD admin |
| [SQL-Server-VM](SQL-Server-VM/) | SQL Server on VM: backup and SQL IaaS agent installation |
| [Storage-Account](Storage-Account/) | Storage Accounts: network rules and service inventory |
| [Virtual-Machine](Virtual-Machine/) | Virtual Machines: creation from VHD, migration, and start/stop by tag |
| [Virtual-Network](Virtual-Network/) | Virtual Networks: subnets, free IPs, and integrations |
| [VPN-Gateway](VPN-Gateway/) | VPN Gateway: connections |
| [App-Service](App-Service/) | App Service / Web Apps: backup, certificates, slots, tags, and VNet integration |

### Root scripts

| Script | Description |
|--------|-------------|
| `Export-AzureResourceBaseline.ps1` | Full inventory (*baseline*) across dozens of resource types — App Gateway, Front Door, Logic Apps, APIM, AKS, Virtual WAN, Functions, Private Endpoints, NSG, Bastion, ExpressRoute, WAF, Firewall, Traffic Manager, Key Vault, DNS zones, Data Factory, Databricks, Redis, and more — producing a multi-sheet Excel report. Requires the **ImportExcel** module and the `$xlfile` variable (path to the `.xlsx`) set before running. |
| `Resolve-PrivateEndpointDns.ps1` | Resolves a list of FQDNs (e.g., private endpoints). |

## Placeholder convention

| Placeholder | Meaning |
|-------------|---------|
| `YOUR-TENANT` | Tenant ID (Azure AD / Entra ID) |
| `YOUR-SUBSCRIPTION` / `YOUR-SUBSCRIPTION-ID` | Subscription name or ID |
| `YOUR-RESOURCE-GROUP` | Resource group name |
| `YOUR-STORAGE-ACCOUNT` / `...-KEY` | Storage account name / access key |
| `YOUR-KEYVAULT` / `YOUR-SECRET` | Key Vault and secret |
| `YOUR-RSV-NAME` | Recovery Services Vault |
| `YOUR-VM-NAME` | Virtual Machine |
| `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` | Generic GUID (fill in with the real value) |

## Disclaimer

These scripts are provided "as is", for reference and operational automation. Test them in a controlled environment before using in production. Operations such as `restore`, `delete`, `disable backup`, and `start/stop` **modify resources** — review them carefully before running.
