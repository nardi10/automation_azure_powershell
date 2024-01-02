Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

Save-AzVhd -SourceUri "https://stgcopy.blob.core.windows.net/vhds/DISK-NAME.vhd" -LocalFilePath "H:\vhd\COPYDISK-NAME.vhd" -ResourceGroupName YOUR-RESOURCE-GROUP
