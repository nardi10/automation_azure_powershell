Connect-AzAccount -Tenant YOUR-TENANT -Subscription YOUR-SUBSCRIPTION

#Get all VNETs
$AZVNETs = Get-AzVirtualNetwork


ForEach ($VNET in $AZVNETs) {

            #Get All Subnets in this VNET
            $AZSubnets = Get-AzVirtualNetwork -Name $VNET.Name | Get-AzVirtualNetworkSubnetConfig
                ForEach ($Subnet in $AZSubnets) {               
                $azaspname = $Subnet.ServiceAssociationLinks.link
                    foreach ($aspname in $azaspname) {
                    #Used for counting later
                    $SubnetConfigured = $Subnet | Select-Object -ExpandProperty IpConfigurations
                    #Gets the mask from the IP configuration (I.e 10.0.0.0/24, turns to just "24")
                    $Mask = $Subnet.AddressPrefix
                    $Mask = $Mask.substring($Mask.Length - 2,2)

                        #Depends on the mask, sets how many available IP's we have - Add more if required
                        switch ($Mask) {
                            '29' { $AvailableAddresses = "3" }
                            '28' { $AvailableAddresses = "11" }
                            '27' { $AvailableAddresses = "27" }
                            '26' { $AvailableAddresses = "59" }
                            '25' { $AvailableAddresses = "123" }
                            '24' { $AvailableAddresses = "251" }
                            '23' { $AvailableAddresses = "507" }
                        }

                        $ipleft = $AvailableAddresses - $SubnetConfigured.Count
                        $info = $VNET.Name + ";" + $VNET.AddressSpace.AddressPrefixes + ";" + $Subnet.Name + ";" + $Subnet.AddressPrefix + ";" + $ipleft + ";" + $SubnetConfigured.Count + ";" + $aspname
                        $info | Out-File "C:\VNETDATAPRDASP.csv" -Append
                        $info
             }

     


}






}