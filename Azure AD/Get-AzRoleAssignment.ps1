Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

$assignments = Get-AzRoleAssignment -RoleDefinitionName YOUR-ROLE-DEFINITION #(for example Owner, Contribuitor)



foreach ($a in $assignments) {
$rg = $a.scope.split("/")
$info = $rg[2] + ";" + $rg[4] + ";" + $a.displayName + ";" + $a.RoleDefinitionName + ";" + $a.ObjectType
$info | Out-File "C:\temp\YOUR_FILE.csv" -Append
}



$Subs = @("YOUR-SUBSCRIPTION")
$accesstype = Get-AzRoleDefinition | where {($_.Name -match "Contributor") -or ($_.Name -match "Owner") -or ($_Name -contains "Administrator")}

foreach($Sub in $Subs){

$SubscriptionName = Set-AzContext -SubscriptionName $Sub
$SubscriptionName.Subscription
    foreach($azaccesstype in $accesstype) {
    $assignments = Get-AzRoleAssignment -RoleDefinitionName $azaccesstype.Name
        foreach ($a in $assignments) {
        $rg = $a.scope.split("/")
        $info = $rg[2] + ";" + $rg[4] + ";" + $a.Scope + ";" + $a.displayName + ";" + $a.RoleDefinitionName + ";" + $a.ObjectType + ";" + $Sub
        $info | Out-File "C:\temp\YOUR_FILE.csv" -Append
        $info
        }
    }
}