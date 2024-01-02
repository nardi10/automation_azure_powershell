

#Validação dados BLOB .vhd

$stContext = New-AzStorageContext -StorageAccountName YOUR-STORAGE-ACCOUNT-NAME -StorageAccountKey YOUR-ACESS-KEY

    $containerdefault = Get-AzStorageContainer -Context $stContext
    foreach ($azcontainerdefault in $containerdefault) {
    $conteudoblob = Get-AzStorageBlob -Context $stContext -Container $azcontainerdefault.name | Where {$_.name -like "*.vhd"}
        foreach ($azconteudoblob in $conteudoblob) {
         $info = $azconteudoblob.Name + ";" + $azcontainerdefault.Name + ";" + $azconteudoblob.Length/1GB
         $info | Out-file "C:\YOUR-FILE-NAME.csv" -Append
         $info
        }
    }


   