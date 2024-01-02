Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

Publish-AzWebapp -ResourceGroupName YOUR-RESOURCE-GROUP-NAME -Name YOUR-FUNCTION-NAME -ArchivePath YOUR PATH #FOR EXAMPLE "C:\TEMP\FILENAME.zip"
