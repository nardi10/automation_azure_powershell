# Application Gateway

Scripts for managing **Azure Application Gateway**, focused on SSL certificates.

| Script | Description |
|--------|-------------|
| `Set-AppGatewayKeyVaultCertificate.ps1` | Associates an SSL certificate stored in **Key Vault** with an Application Gateway, using a *managed identity*. Strips the secret version so the gateway always uses the latest version on future syncs. |
| `Get-AppGatewayCertificate.ps1` | Lists the certificates of the HTTPS *listeners* and *backends* of one or more Application Gateways (Subject, Issuer, Serial, Thumbprint, validity). Parameters: `-RG`, `-AppGWName`, `-Details`, `-Export` (exports the `.cer` files). |

> Prerequisites: **Az** module and `Connect-AzAccount`.
