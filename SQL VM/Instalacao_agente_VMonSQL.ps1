Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

$vm2 = Get-AzVM -Name YOUR-VM-NAME -ResourceGroupName YOUR-RG-VM-NAME

New-AzSqlVM -Name $vm2.Name -ResourceGroupName $vm2.ResourceGroupName -Location $vm2.Location -LicenseType DR -SqlManagementType Full

Update-AzSqlVM -Name $vm2.Name -ResourceGroupName $vm2.ResourceGroupName -SqlManagementType Full





# Get the existing  Compute VM
$vm = Get-AzVM -Name YOUR-VM-NAME -ResourceGroupName YOUR-RG-VM-NAME

# Register with SQL IaaS Agent extension in full mode
New-AzSqlVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName -SqlManagementType Full