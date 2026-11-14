# Import the ImportExcel module
Import-Module ImportExcel

# List of Subscriptions
$Subs = @("YOUR-SUBSCRIPTION-1", "YOUR-SUBSCRIPTION-2", "YOUR-SUBSCRIPTION-3")

# Initialize the lists for each service
$blobReport = @()
$fileShareReport = @()
$queueReport = @()
$tableReport = @()
$errorLog = @()

foreach($Sub in $Subs) {
    # Select the Subscription
    Set-AzContext -Subscription $Sub
    
    # Get the Storage Accounts of the Subscription
    $storageAccounts = Get-AzStorageAccount
    
    foreach ($storageAccount in $storageAccounts) {
        $context = $storageAccount.Context
        
        # Blob Containers
        try {
            $blobContainers = Get-AzStorageContainer -Context $context
            foreach ($blob in $blobContainers) {
                $blobReport += [PSCustomObject]@{
                    Subscription = $Sub
                    StorageAccountName = $storageAccount.StorageAccountName
                    ResourceType = "Blob Container"
                    ResourceName = $blob.Name
                }
            }
        }
        catch {
            $errorLog += [PSCustomObject]@{
                Subscription = $Sub
                StorageAccountName = $storageAccount.StorageAccountName
                Error = "Failed to access Blob Containers: $_"
            }
        }
        
        # File Shares
        try {
            $fileShares = Get-AzStorageShare -Context $context
            foreach ($fileShare in $fileShares) {
                $fileShareReport += [PSCustomObject]@{
                    Subscription = $Sub
                    StorageAccountName = $storageAccount.StorageAccountName
                    ResourceType = "File Share"
                    ResourceName = $fileShare.Name
                }
            }
        }
        catch {
            $errorLog += [PSCustomObject]@{
                Subscription = $Sub
                StorageAccountName = $storageAccount.StorageAccountName
                Error = "Failed to access File Shares: $_"
            }
        }
        
        # Queues
        try {
            $queues = Get-AzStorageQueue -Context $context
            foreach ($queue in $queues) {
                $queueReport += [PSCustomObject]@{
                    Subscription = $Sub
                    StorageAccountName = $storageAccount.StorageAccountName
                    ResourceType = "Queue"
                    ResourceName = $queue.Name
                }
            }
        }
        catch {
            $errorLog += [PSCustomObject]@{
                Subscription = $Sub
                StorageAccountName = $storageAccount.StorageAccountName
                Error = "Failed to access Queues: $_"
            }
        }
        
        # Tables
        try {
            $tables = Get-AzStorageTable -Context $context
            foreach ($table in $tables) {
                $tableReport += [PSCustomObject]@{
                    Subscription = $Sub
                    StorageAccountName = $storageAccount.StorageAccountName
                    ResourceType = "Table"
                    ResourceName = $table.Name
                }
            }
        }
        catch {
            $errorLog += [PSCustomObject]@{
                Subscription = $Sub
                StorageAccountName = $storageAccount.StorageAccountName
                Error = "Failed to access Tables: $_"
            }
        }
    }
}

# Path to save the report
$outputFile = "C:\Temp\AzureStorageReport3.xlsx"

# Create the Excel file with the first sheet
$blobReport | Export-Excel -Path $outputFile -WorksheetName "Blob Containers" -AutoSize -ClearSheet

# Add the other sheets in the desired order
$fileShareReport | Export-Excel -Path $outputFile -WorksheetName "File Shares" -AutoSize -Append
$queueReport | Export-Excel -Path $outputFile -WorksheetName "Queues" -AutoSize -Append
$tableReport | Export-Excel -Path $outputFile -WorksheetName "Tables" -AutoSize -Append
$errorLog | Export-Excel -Path $outputFile -WorksheetName "Error Log" -AutoSize -Append

Write-Host "Report generated at: $outputFile"
