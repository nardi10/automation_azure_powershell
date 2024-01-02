
Connect-AzureAD -TenantId YOUR-TENANT

$groups = Get-content "C:\Temp\Grupos.txt"

$caminho = $env:temp+"\Users_List2.csv"

New-Item -Path $caminho -type file

foreach ($g in $groups) {
$users = Get-AzADGroupMember -GroupDisplayName $g
foreach($u in $users) {
$info = $g + ";" + $u.DisplayName + ";" + $u.Id
$info | Out-File $caminho -Append
}
}

