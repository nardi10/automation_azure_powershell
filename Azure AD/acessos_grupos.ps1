

$Subs = @("EDP - Prod")
$ResourceGroups = @(

)

# Captura qualquer role que contenha 'Contributor' ou seja 'Owner' ou 'Administrator'
$accesstype = Get-AzRoleDefinition | Where-Object {
    ($_.Name -match "(?i)contributor") -or ($_.Name -match "Owner") -or ($_.Name -match "Administrator")
}

foreach ($Sub in $Subs) {
    $SubscriptionContext = Set-AzContext -SubscriptionName $Sub
    
    foreach ($rgName in $ResourceGroups) {
        foreach ($azaccesstype in $accesstype) {
            $assignments = Get-AzRoleAssignment -RoleDefinitionName $azaccesstype.Name | Where-Object {
                $_.Scope -match "/resourceGroups/$rgName"
            }
            
            foreach ($a in $assignments) {
                $info = "$rgName;$a.Scope;$a.displayName;$a.RoleDefinitionName;$a.ObjectType;$Sub"
                $info | Out-File "C:\temp\acessos_terraform_prd.csv" -Append
                $info
            }
        }
    }
}









