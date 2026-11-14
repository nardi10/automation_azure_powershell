
Connect-AzureAD -TenantId YOUR-TENANT

$groups = Get-content "C:\Temp\Grupos.txt"

$path = $env:temp+"\Users_List2.csv"

New-Item -Path $path -type file

foreach ($g in $groups) {
$users = Get-AzADGroupMember -GroupDisplayName $g
foreach($u in $users) {
$info = $g + ";" + $u.DisplayName + ";" + $u.Id
$info | Out-File $path -Append
}
}

