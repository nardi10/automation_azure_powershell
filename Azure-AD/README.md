# Azure AD / Entra ID

Scripts for identity governance: groups, roles, and access assignments.

| Script | Description |
|--------|-------------|
| `Get-AzADGroupMember.ps1` | Exports the members (DisplayName and Id) of the Azure AD groups listed in a text file. Uses `Connect-AzureAD`. |
| `Get-AzRoleAssignment.ps1` | Lists *role assignments* (by role, e.g., Owner/Contributor/Administrator) across one or more subscriptions and exports to CSV. |
| `Get-RoleAssignmentByResourceGroup.ps1` | Lists access (Contributor/Owner/Administrator) per resource group in a subscription and exports to CSV. |
| `Get-RoleDefinition.ps1` | Exports a specific role definition in JSON format. |
| `New-CustomRole.ps1` | Creates a *custom role* from an input JSON file (sample JSON included in the script itself). |

> Prerequisites: **Az** and/or **AzureAD** modules; prior authentication.
