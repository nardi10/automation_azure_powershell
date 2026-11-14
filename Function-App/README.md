# Azure Functions

Scripts for deploying and configuring **Azure Functions**.

| Script | Description |
|--------|-------------|
| `Publish-FunctionAppCode.ps1` | Publishes a `.zip` package to an Azure Function (`Publish-AzWebApp -ArchivePath`). |
| `Set-FunctionAppTier.ps1` | Changes the *tier*/SKU of the App Service Plan associated with the Function (`Set-AzAppServicePlan -tier`). |

> Prerequisites: **Az** module and `Connect-AzAccount`.
