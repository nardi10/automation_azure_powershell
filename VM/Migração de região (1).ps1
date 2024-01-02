
$DestResourceGroupName = "YOUR RESOURCE GROUP OF DEST"
$DestLocationName = "Brazil South"
$VNETResourceGroupName = "YOUR RG OF VNET"
$VNETName = "YOUR VNET NAME"
$SubnetName = "YOUR SUBNET NAME"
$MyNewVM1Name = "YOUR-VM-NAME"
$DestVMOSVhd = YOUR-BLOB #For Example "https://teste.blob.core.windows.net/container-teste/vm1-osdisk-20211022-195907.vhd" #URL do vhd
$VMSize = "Standard_B2s"

$DestVirtualNetwork = Get-AzureRMVirtualNetwork -ResourceGroupName $VNETResourceGroupName -Name $VNETName
$subnet = Get-AzureRMVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $DestVirtualNetwork
$nicname = $MyNewVM1Name + "-NIC"
$NetworkInterface = New-AzureRMNetworkInterface -ResourceGroupName $DestResourceGroupName  -Name $nicname -Location $DestLocationName -SubnetId $subnet.Id

$DestVmConfig = New-AzureRMVMConfig -VMName $MyNewVM1Name -VMSize $VMSize
$DestVmConfig = Set-AzureRMVMOSDisk -VM $DestVmConfig -Name $MyNewVM1Name -VhdUri $DestVMOSVhd -CreateOption Attach -Linux #-Linux
$DestVmConfig = Add-AzureRMVMNetworkInterface -VM $DestVmConfig -Id $NetworkInterface.Id

$NewVm = New-AzureRMVM -VM $DestVMConfig -Location $DestLocationName -ResourceGroupName $DestResourceGroupName

#Get-AzureRMVMSize -Location brazilsouth | where {$_.Name -eq "Standard_D32s_v3"}

#Write-Host "--------Migrando para managed disk-------------"
#Stop the VM if running
#Stop-AzVM -ResourceGroupName $DestResourceGroupName -Name $MyNewVM1Name -Force
#ConvertTo-AzVMManagedDisk -ResourceGroupName $DestResourceGroupName -VMName $MyNewVM1Name
