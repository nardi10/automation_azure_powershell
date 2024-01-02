##create $SAS


$rgdisk = Get-AzResource -ResourceGroupName YOUR-RESOURCE-GROUP
$sas = Grant-AzDiskAccess -ResourceGroupName YOUR-RESOURCE-GROUP -DiskName $rgdisk.name[1] -DurationInSecond 3600 -Access Read 
$destContext = New-AzStorageContext -StorageAccountName YOUR-STORAGE-ACCOUNT -StorageAccountKey YOUR-STORAGE-ACCOUNT-ACCESS-KEY
Start-AzStorageBlobCopy -AbsoluteUri $sas.AccessSAS -DestContainer CONTAINER-DESTINATION -DestContext $destContext -DestBlob YOUR-BLOBNAME #FOR EXAMPLE osdisk-20211028-132725.vhd




