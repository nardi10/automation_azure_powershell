# Importa o módulo ImportExcel
Import-Module ImportExcel

# Lista de Subscriptions
$Subs = @("EDP - Prod", "EDP - Dev/Test", "EDPBR-DATADRIVEN-DEV", "EDPBR-DATADRIVEN-PRD01")

# Inicializa as listas para cada serviço
$blobReport = @()
$fileShareReport = @()
$queueReport = @()
$tableReport = @()
$errorLog = @()

foreach($Sub in $Subs) {
    # Seleciona a Subscription
    Set-AzContext -Subscription $Sub
    
    # Obtém as Storage Accounts da Subscription
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

# Caminho para salvar o relatório
$outputFile = "C:\Temp\AzureStorageReport3.xlsx"

# Cria o Excel com a primeira aba
$blobReport | Export-Excel -Path $outputFile -WorksheetName "Blob Containers" -AutoSize -ClearSheet

# Adiciona as outras abas na ordem desejada
$fileShareReport | Export-Excel -Path $outputFile -WorksheetName "File Shares" -AutoSize -Append
$queueReport | Export-Excel -Path $outputFile -WorksheetName "Queues" -AutoSize -Append
$tableReport | Export-Excel -Path $outputFile -WorksheetName "Tables" -AutoSize -Append
$errorLog | Export-Excel -Path $outputFile -WorksheetName "Error Log" -AutoSize -Append

Write-Host "Relatório gerado em: $outputFile"
