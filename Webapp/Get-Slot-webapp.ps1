
Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

$asp  = Get-AzAppServicePlan
foreach ($azasp in $asp) {
    $webapp = Get-AzWebApp -AppServicePlan $azasp
    foreach ($azwebapp in $webapp) {
    $slot = Get-AzWebAppSlot -WebApp $azwebapp
        foreach ($azslot in $slot) {
        $info = $azwebapp.Name + ";" + $azwebapp.ResourceGroup + ";" + $azslot.Name + ";" + $azslot.DefaultHostName + ";" + $azasp.Name + ";" + $azasp.Sku.Tier
        $info | Out-file "C:\Temp\slot_webapp_devqa.csv" -Append
        $info
        }



    }

}
