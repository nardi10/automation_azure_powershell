# Network Security Groups (NSG)

Scripts for **NSG** auditing.

| Script | Description |
|--------|-------------|
| `Export-NsgRule.ps1` | Iterates over **all subscriptions** and exports to CSV all NSG rules — *custom* and *default* — including source/destination, ports, Application Security Groups, priority, and direction. Generates one CSV per subscription. |

> Prerequisites: **Az** module and `Connect-AzAccount`.
