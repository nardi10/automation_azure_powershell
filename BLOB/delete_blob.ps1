Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

#Get all deleted blob within a container
$StorageAccount = Get-AzStorageAccount | Where-Object { $_.StorageAccountName -eq "YOUR-STORAGE-ACCOUNT" }
$Blobs = Get-AzStorageContainer -Name "YOUR-CONTAINER" -Context $StorageAccount.Context | Get-AzStorageBlob -IncludeDeleted
$cont = Get-AzStorageContainer -Name "YOUR-CONTAINER" -Context $StorageAccount.Context

#$startDate = Get-Date -Year 2021 -Month 3 -Day 15
#$endDate = Get-Date -Year 2021 -Month 9 -Day 1
$DeletedBlobs = $($Blobs | Where-Object { $_.LastModified.Year -eq 2022})
$item = $DeletedBlobs
$item.count
#Get your Bearer access token, run first Connect-AzAccount to authenticate on Azure
$resource = "https://storage.azure.com"
$context = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile.DefaultContext
$accessToken = [Microsoft.Azure.Commands.Common.Authentication.AzureSession]::Instance.AuthenticationFactory.Authenticate($context.Account, $context.Environment, $context.Tenant.Id.ToString(), $null, [Microsoft.Azure.Commands.Common.Authentication.ShowDialog]::Never, $null, $resource).AccessToken
   

#Restore
foreach ($DeletedBlob in $item) {
    Write-Host "Restoring : $($DeletedBlob.Name)"
    $uri = "$($DeletedBlob.BlobBaseClient.Uri.AbsoluteUri)?comp=undelete"
    $headers = @{
        'Authorization' = "Bearer $accessToken";
        'x-ms-date'     = $((get-date -Format r).ToString());
        'x-ms-version'  = "2019-12-12"; 
    }
    $restore = Invoke-RestMethod -Method 'Put' -Uri $uri -Headers $headers
    $restore
    $remove = Remove-AzStorageBlob -Blob $DeletedBlob.Name -Container $cont.Name -Context $StorageAccount.Context
    $remove
}

