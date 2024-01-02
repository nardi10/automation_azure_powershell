Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

$DestResourceGroupName = "YOUR RESOURCE GROUP OF DEST"
$DestLocationName = "Brazil South"
$VNETResourceGroupName = "YOUR RG OF VNET"
$VNETName = "YOUR VNET NAME"
$SubnetName = "YOUR SUBNET NAME"
$MyNewVM1Name = "YOUR-VM-NAME"
$DestVMOSVhd = YOUR-BLOB #For Example "https://teste.blob.core.windows.net/container-teste/vm1-osdisk-20211022-195907.vhd" #URL do vhd
$VMSize = "Standard_B2s"

$DestVirtualNetwork = Get-AzVirtualNetwork -ResourceGroupName $VNETResourceGroupName -Name $VNETName
$subnet = Get-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $DestVirtualNetwork
$nicname = $MyNewVM1Name + "-NIC"
$NetworkInterface = New-AzNetworkInterface -ResourceGroupName $DestResourceGroupName  -Name $nicname -Location $DestLocationName -SubnetId $subnet.Id

$DestVmConfig = New-AzVMConfig -VMName $MyNewVM1Name -VMSize $VMSize
##$DestVmConfig | Set-AzVMPlan -Name "2016-Datacenter" -Publisher "MicrosoftWindowsServer"
$DestVmConfig = Set-AzVMOSDisk -VM $DestVmConfig -Name $MyNewVM1Name -VhdUri $DestVMOSVhd -CreateOption Attach -Linux #-Linux
$DestVmConfig = Add-AzVMNetworkInterface -VM $DestVmConfig -Id $NetworkInterface.Id

$NewVm = New-AzVM -VM $DestVMConfig -Location $DestLocationName -ResourceGroupName $DestResourceGroupName



#Get-AzureRMVMSize -Location brazilsouth | where {$_.Name -eq "Standard_D32s_v3"}

#Write-Host "--------Migrando para managed disk-------------"
#Stop the VM if running
#Stop-AzVM -ResourceGroupName $DestResourceGroupName -Name $MyNewVM1Name -Force
#ConvertTo-AzVMManagedDisk -ResourceGroupName $DestResourceGroupName -VMName $MyNewVM1Name

