# Virtual Networks (VNET)

Scripts for **VNet and subnet** inventory.

| Script | Description |
|--------|-------------|
| `Get-VNetSubnet.ps1` | Lists VNets and their subnets (address space and prefix) and exports to CSV. |
| `Get-VNetSubnetAspUsage.ps1` | Lists subnets with **App Service Plan** integration (*service association link*) and calculates the free IPs based on the subnet mask. |
| `Get-VNetSubnetNicUsage.ps1` | Lists subnets with associated **NICs** and calculates the free IPs based on the mask. |

> Prerequisites: **Az** module and `Connect-AzAccount`.
