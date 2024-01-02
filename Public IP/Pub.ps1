Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION



$public = Get-AzPublicIpAddress
foreach ( $azpublic in $public) {
    $info = $azpublic.Name + ";" + $azpublic.IpAddress + ";" + $azpublic.Location + ";" + $azpublic.Sku.Name + ";" + $azpublic.IpConfiguration.Id
    $info | Out-file "C:\Info_PublicIP.csv" -Append
    $info
}



