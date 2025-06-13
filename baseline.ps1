
function reports_AppGateway {
    param([string]$ambiente_agw)

    $report_agw = @()
    $getagw = Get-AzApplicationGateway

    foreach ($agw in $getagw) {
        $info_agw = "" | Select-Object Name, ResourceGroupName, Id, Location, Ambiente, SKU
        $info_agw.Name              = $agw.Name
        $info_agw.ResourceGroupName = $agw.ResourceGroupName
        $info_agw.Id                = $agw.Id
        $info_agw.Location          = $agw.Location
        $info_agw.Ambiente          = $ambiente_agw
        $info_agw.SKU               = $agw.Sku.Tier

        $report_agw += $info_agw
    }

    $report_agw | Export-Excel $xlfile -NoNumberConversion * -AutoSize -StartRow 1 -TableName "AppGateway" -WorksheetName "Application Gateway" -Append -KillExcel
    return $report_agw
}

####################################################

function Get-AzDnsResolversReport {
    param ([string]$subscription)

    # Definir o contexto da assinatura
    Set-AzContext -SubscriptionId $subscription

    # Obter todos os resolutores de DNS
    $dnsResolvers = Get-AzDnsResolver
    $report = @()

    foreach ($resolver in $dnsResolvers) {
        # Gerar o relatório com as informações do resolutor de DNS
        $report += [PSCustomObject]@{
            ResourceType    = 'DNS Resolver'
            ResourceGroup   = $resolver.ResourceGroupName
            Name            = $resolver.Name
            Location        = $resolver.Location
            Tags            = ($resolver.Tags | ForEach-Object { "$($_.Key): $($_.Value)" }) -join ', '
        }
    }

    return $report
}


####################################################

function Get-AzDataFactoryReport {
    param ([string]$subscription)

    # Definir o contexto da assinatura
    Set-AzContext -SubscriptionId $subscription

    # Obter todos os Data Factories da assinatura
    $dataFactories = Get-AzDataFactory
    $report = @()

    foreach ($dataFactory in $dataFactories) {
        $report += [PSCustomObject]@{
            ResourceType       = 'Azure Data Factory'
            ResourceGroup     = $dataFactory.ResourceGroupName
            Subscription       = $subscription
            Name               = $dataFactory.Name
            Location           = $dataFactory.Location
            CreatedTime        = $dataFactory.CreatedTime
            LastModifiedTime   = $dataFactory.LastModifiedTime
        }
    }

    return $report
}

####################################################

function Get-AzDatabricksWorkspaceReport {
    param ([string]$subscription)

    # Definir o contexto da assinatura
    Set-AzContext -SubscriptionId $subscription

    # Obter os workspaces do Azure Databricks
    $databricksWorkspaces = Get-AzDatabricksWorkspace
    $report = @()

    foreach ($workspace in $databricksWorkspaces) {
        $report += [PSCustomObject]@{
            ResourceType       = 'Azure Databricks Workspace'
            ResourceGroup     = $workspace.ResourceGroupName
            Subscription       = $subscription
            Name               = $workspace.Name
            Location           = $workspace.Location
            CreatedTime        = $workspace.CreatedDate
            SparkVersion       = $workspace.SparkVersion
            ManagedResourceGroup = $workspace.ManagedResourceGroup
        }
    }

    return $report
}

####################################################


function Get-AzBotServiceReport {
    param ([string]$subscription)

    # Definir o contexto da assinatura
    Set-AzContext -SubscriptionId $subscription

    # Obter todos os Bot Services da assinatura
    $botServices = Get-AzBotService
    $report = @()

    foreach ($botService in $botServices) {
        $report += [PSCustomObject]@{
            ResourceType       = 'Azure Bot Service'
            ResourceGroup     = $botService.ResourceGroupName
            Subscription       = $subscription
            Name               = $botService.Name
            Location           = $botService.Location
            BotType            = $botService.BotType
            CreatedTime        = $botService.CreatedTime
            Endpoints          = $botService.Endpoint
        }
    }

    return $report
}

#########################################################

function Get-AzMachineLearningWorkspaceReport {
    param ([string]$subscription)

    # Definir o contexto da assinatura
    Set-AzContext -SubscriptionId $subscription

    # Obter os workspaces do Azure Machine Learning
    $amlWorkspaces = Get-AzMLWorkspace
    $report = @()

    foreach ($workspace in $amlWorkspaces) {
        $report += [PSCustomObject]@{
            ResourceType       = 'Azure Machine Learning Workspace'
            ResourceGroup     = $workspace.ResourceGroupName
            Subscription       = $subscription
            Name               = $workspace.Name
            Location           = $workspace.Location
            WorkspaceState     = $workspace.State
            CreatedTime        = $workspace.CreatedDate
        }
    }

    return $report
}

#########################################################

function Get-AzRecoveryServicesVaultReport {
    param ([string]$subscription)

    # Definir o contexto da assinatura
    Set-AzContext -SubscriptionId $subscription

    # Obter os Recovery Services Vaults da Subscription
    $vaults = Get-AzRecoveryServicesVault
    $report = @()

    foreach ($vault in $vaults) {
        $report += [PSCustomObject]@{
            ResourceType       = 'Recovery Services Vault'
            ResourceGroup     = $vault.ResourceGroupName
            Subscription       = $subscription
            VaultName          = $vault.Name
            Location           = $vault.Location
            VaultType          = $vault.VaultType
        }
    }

    return $report
}

#########################################################

function Get-AzBatchAccountReport {
    param ([string]$subscription)

    # Definir o contexto da assinatura
    Set-AzContext -SubscriptionId $subscription

    $report = @()

    # Obter todas as contas de Azure Batch
    $batchAccounts = Get-AzBatchAccount
    foreach ($batch in $batchAccounts) {
        $report += [PSCustomObject]@{
            ResourceType  = 'Azure Batch Account'
            ResourceGroup = $batch.ResourceGroupName
            Name          = $batch.AccountName
            Location      = $batch.Location
            PoolQuota     = $batch.PoolQuota
            CoreQuota     = $batch.CoreQuota
            DedicatedCoreQuota = $batch.DedicatedCoreQuota
            LowPriorityCoreQuota = $batch.LowPriorityCoreQuota
            ProvisioningState = $batch.ProvisioningState
        }
    }

    return $report
}

#########################################################

function Get-AzContainerAppsReport {
    param ([string]$subscription)

    # Definir o contexto da assinatura
    Set-AzContext -SubscriptionId $subscription

    $report = @()

    # Obter todos os Azure Container Apps
    $containerApps = Get-AzContainerApp
    foreach ($app in $containerApps) {
        $ingress = "None"
        if ($app.Configuration.Ingress) {
            $ingress = $app.Configuration.Ingress.Fqdn
        }

        $report += [PSCustomObject]@{
            ResourceType    = 'Azure Container App'
            ResourceGroup   = $app.ResourceGroupName
            Name            = $app.Name
            Location        = $app.Location
            Environment     = $app.ManagedEnvironmentId.Split('/')[-1]  # Obtém o nome do ambiente gerenciado
            Ingress         = $ingress
            WorkloadProfile = $app.WorkloadProfileName
            Status          = $app.ProvisioningState
        }
    }

    return $report
}


#########################################################


function Get-AzServiceFabricReport {
    param ([string]$subscription)

    # Definir o contexto da assinatura
    Set-AzContext -SubscriptionId $subscription

    $report = @()

    # Obter todos os clusters do Azure Service Fabric
    $clusters = Get-AzServiceFabricCluster
    foreach ($cluster in $clusters) {
        $report += [PSCustomObject]@{
            ResourceType     = 'Azure Service Fabric'
            ResourceGroup    = $cluster.ResourceGroupName
            Name             = $cluster.Name
            Location         = $cluster.Location
            ClusterState     = $cluster.ClusterState
            ClusterVersion   = $cluster.ClusterVersion
            ClusterEndpoint  = $cluster.ClusterEndpoint
            ReliabilityLevel = $cluster.ReliabilityLevel
        }
    }

    return $report
}

#########################################################

function Get-AzContainerRegistryReport {
    param ([string]$subscription)

    # Definir o contexto da assinatura
    Set-AzContext -SubscriptionId $subscription

    $report = @()

    # Obter todos os Azure Container Registries (ACR)
    $registries = Get-AzContainerRegistry
    foreach ($registry in $registries) {
        $report += [PSCustomObject]@{
            ResourceType    = 'Azure Container Registry'
            ResourceGroup   = $registry.ResourceGroupName
            Name            = $registry.Name
            Location        = $registry.Location
            SKU             = $registry.Sku.Name
            AdminEnabled    = $registry.AdminUserEnabled
            LoginServer     = $registry.LoginServer
            Status          = $registry.ProvisioningState
        }
    }

    return $report
}

#########################################################

function Get-AzACIReport {
    param ([string]$subscription)

    # Definir o contexto da assinatura
    Set-AzContext -SubscriptionId $subscription

    $report = @()

    # Obter todos os Azure Container Instances (ACI)
    $containerGroups = Get-AzContainerGroup
    foreach ($container in $containerGroups) {
        $report += [PSCustomObject]@{
            ResourceType  = 'Azure Container Instance'
            ResourceGroup = $container.ResourceGroupName
            Name          = $container.Name
            Location      = $container.Location
            State         = $container.ProvisioningState
            FQDN          = $container.Fqdn
            IPAddress     = $container.IpAddress
            OS            = $container.OsType
            Containers    = ($container.Containers | ForEach-Object { $_.Name }) -join ', '
        }
    }

    return $report
}

#########################################################


function Get-AzRedisCacheReport {
    param ([string]$subscription)

    $redisCaches = Get-AzRedisCache -Name rds-yaris-prd
    $report = @()

    foreach ($redisCache in $redisCaches) {

        $report += [PSCustomObject]@{
            ResourceType      = 'Redis Cache'
            ResourceGroup     = $redisCache.ResourceGroupName
            Name              = $redisCache.Name
            Location          = $redisCache.Location
            sku              = $redisCache.Sku
        }
    }
    return $report
}

#########################################################



function Get-AzKeyVaultReport {
    param ([string]$subscription)

    # Definir o contexto da assinatura
    Set-AzContext -SubscriptionId $subscription

    # Obter os Key Vaults da Subscription
    $keyVaults = Get-AzKeyVault
    $report = @()

    foreach ($keyVault in $keyVaults) {
        # Chaves (Keys)
        $keys = Get-AzKeyVaultKey -VaultName $keyVault.VaultName
        foreach ($key in $keys) {
            $report += [PSCustomObject]@{
                ResourceType     = 'Key'
                ResourceGroup   = $keyVault.ResourceGroupName
                Subscription     = $subscription
                KeyVaultName     = $keyVault.VaultName
                Name             = $key.Name
                Enabled          = $key.Attributes.Enabled
                Created          = $key.Attributes.Created
                Expires          = $key.Attributes.Expires
            }
        }

        # Segredos (Secrets)
        $secrets = Get-AzKeyVaultSecret -VaultName $keyVault.VaultName
        foreach ($secret in $secrets) {
            $report += [PSCustomObject]@{
                ResourceType     = 'Secret'
                ResourceGroup   = $keyVault.ResourceGroupName
                Subscription     = $subscription
                KeyVaultName     = $keyVault.VaultName
                Name             = $secret.Name
                Enabled          = $secret.Attributes.Enabled
                Created          = $secret.Attributes.Created
                Expires          = $secret.Attributes.Expires
            }
        }

        # Certificados (Certificates)
        $certificates = Get-AzKeyVaultCertificate -VaultName $keyVault.VaultName
        foreach ($certificate in $certificates) {
            $report += [PSCustomObject]@{
                ResourceType     = 'Certificate'
                ResourceGroup   = $keyVault.ResourceGroupName
                Subscription     = $subscription
                KeyVaultName     = $keyVault.VaultName
                Name             = $certificate.Name
                Enabled          = $certificate.Attributes.Enabled
                Created          = $certificate.Attributes.Created
                Expires          = $certificate.Attributes.Expires
            }
        }
    }

    return $report
}


#########################################################

function Get-AzDnsZonesReport {
    param ([string]$subscription)

    # Definir o contexto da assinatura
    Set-AzContext -SubscriptionId $subscription

    # Obter todas as zonas de DNS públicas
    $dnsZones = Get-AzDnsZone
    $report = @()

    foreach ($zone in $dnsZones) {
        # Gerar o relatório com as informações da zona de DNS pública
        $report += [PSCustomObject]@{
            ResourceType    = 'DNS Zone'
            ResourceGroup   = $zone.ResourceGroupName
            Name            = $zone.Name
            Location        = $zone.Location
            Tags            = ($zone.Tags | ForEach-Object { "$($_.Key): $($_.Value)" }) -join ', '
        }
    }

    return $report
}

#########################################################

function reports_FrontDoor {
    param([string]$subscription)

    # Definir o contexto da assinatura
    Set-AzContext -SubscriptionId $subscription

    # Obter todos os Azure Front Door
    $report_fd = @()
    $getfd = Get-AzFrontDoor

    foreach ($fd in $getfd) {
        $info_fd = "" | Select-Object NAME, LOCATION, RESOURCEGROUP, ENABLEDSTATE, FRONTENDHOSTNAMES
        $info_fd.NAME              = $fd.Name
        $info_fd.LOCATION          = $fd.Location
        $info_fd.RESOURCEGROUP     = $fd.ResourceGroupName
        $info_fd.ENABLEDSTATE      = $fd.EnabledState
        $info_fd.FRONTENDHOSTNAMES = ($fd.FrontendEndpoints | ForEach-Object { $_.HostName }) -join ", "

        $report_fd += $info_fd
    }

    $report_fd | Export-Excel $xlfile -NoNumberConversion * -AutoSize -StartRow 1 -TableName "FrontDoor" -WorksheetName "Front Door" -Append -KillExcel
    return $report_fd
}



#########################################################


$report = @()

# Lista de Subscriptions
$Subs = @("YOUR-SUBSCRIPTION")

foreach($Sub in $Subs) {
    # Seleciona a Subscription
    Set-AzContext -Subscription $Sub
    
    # Obtém as Storage Accounts da Subscription
    $storageAccounts = Get-AzStorageAccount
    
    foreach ($storageAccount in $storageAccounts) {
        $context = $storageAccount.Context
        
        # Blob Containers
        $blobContainers = Get-AzStorageContainer -Context $context
        
        # File Shares
        $fileShares = Get-AzStorageFileShare -Context $context
        
        # Queues
        $queues = Get-AzStorageQueue -Context $context
        
        # Tables
        $tables = Get-AzStorageTable -Context $context

        # Adiciona ao relatório
        $report += [PSCustomObject]@{
            Subscription = $Sub
            StorageAccountName = $storageAccount.Name
            BlobContainers = ($blobContainers | Select-Object -ExpandProperty Name) -join ", "
            FileShares = ($fileShares | Select-Object -ExpandProperty Name) -join ", "
            Queues = ($queues | Select-Object -ExpandProperty Name) -join ", "
            Tables = ($tables | Select-Object -ExpandProperty Name) -join ", "
        }
    }
}

# Exibe o relatório
$report | Format-Table -AutoSize


#########################################################

function Get-AzPrivateDnsZonesReport {
    param ([string]$subscription)

    # Definir o contexto da assinatura
    Set-AzContext -SubscriptionId $subscription

    # Obter todas as zonas de DNS privadas
    $privateDnsZones = Get-AzPrivateDnsZone
    $report = @()

    foreach ($zone in $privateDnsZones) {
        # Gerar o relatório com as informações da zona de DNS privada
        $report += [PSCustomObject]@{
            ResourceType    = 'Private DNS Zone'
            ResourceGroup   = $zone.ResourceGroupName
            Name            = $zone.Name
            Location        = $zone.Location
            ZoneType        = $zone.ZoneType
            Tags            = ($zone.Tags | ForEach-Object { "$($_.Key): $($_.Value)" }) -join ', '
        }
    }

    return $report
}

#########################################################


function reports_AzureLogicApps {
    param([string]$ambiente_logicapps)

    $LogicApps = Get-AzLogicApp
    $report_logicapps = @()

    foreach ($logicApp in $LogicApps) {
        $info_logicapp = "" | select ResourceGroup, Name, Location, Sku, ProvisioningState, State, Subscription
        $info_logicapp.ResourceGroup     = $logicApp.ResourceGroupName
        $info_logicapp.Name              = $logicApp.Name
        $info_logicapp.Location          = $logicApp.Location
        $info_logicapp.Sku               = $logicApp.Sku.Name
        $info_logicapp.ProvisioningState = $logicApp.ProvisioningState
        $info_logicapp.State             = $logicApp.State
        $info_logicapp.Subscription      = $ambiente_logicapps
        $report_logicapps += $info_logicapp
    }

    $report_logicapps | Export-Excel $xlfile -NoNumberConversion * -AutoSize -StartRow 1 -TableName "AzureLogicApps" -WorksheetName "Logic Apps" -Append -KillExcel
    return $report_logicapps
}


#########################################################

function reports_AzureAPIM {
    param([string]$ambiente_apim)

    $APIMs = Get-AzApiManagement
    $report_apim = @()

    foreach ($apim in $APIMs) {
        $info_apim = "" | select ResourceGroup, Name, Location, Sku, ProvisioningState, VirtualNetwork, Subscription
        $info_apim.ResourceGroup     = $apim.ResourceGroupName
        $info_apim.Name              = $apim.Name
        $info_apim.Location          = $apim.Location
        $info_apim.Sku               = $apim.Sku.Name
        $info_apim.ProvisioningState = $apim.ProvisioningState
        $info_apim.VirtualNetwork    = $apim.VirtualNetworkConfiguration.VnetId
        $info_apim.Subscription      = $ambiente_apim
        $report_apim += $info_apim
    }

    $report_apim | Export-Excel $xlfile -NoNumberConversion * -AutoSize -StartRow 1 -TableName "AzureAPIM" -WorksheetName "API Management" -Append -KillExcel
    return $report_apim
}


#########################################################


function reports_AzureAKS {
    param([string]$ambiente_aks)

    $AKSClusters = Get-AzAksCluster
    $report_aks = @()

    foreach ($aks in $AKSClusters) {
        $info_aks = "" | select ResourceGroup, Name, Location, KubernetesVersion, NodeResourceGroup, NodeCount, VMSize, NetworkPlugin, ProvisioningState, Subscription
        $info_aks.ResourceGroup     = $aks.ResourceGroupName
        $info_aks.Name              = $aks.Name
        $info_aks.Location          = $aks.Location
        $info_aks.KubernetesVersion = $aks.KubernetesVersion
        $info_aks.NodeResourceGroup = $aks.NodeResourceGroup
        $info_aks.NodeCount         = ($aks.AgentPoolProfiles | Measure-Object -Property Count -Sum).Sum
        $info_aks.VMSize            = ($aks.AgentPoolProfiles | ForEach-Object { $_.VmSize }) -join ", "
        $info_aks.NetworkPlugin     = $aks.NetworkProfile.NetworkPlugin
        $info_aks.ProvisioningState = $aks.ProvisioningState
        $info_aks.Subscription      = $ambiente_aks
        $report_aks += $info_aks
    }

    $report_aks | Export-Excel $xlfile -NoNumberConversion * -AutoSize -StartRow 1 -TableName "AzureAKS" -WorksheetName "Kubernetes Service" -Append -KillExcel
    return $report_aks
}


#########################################################


function reports_AzureVirtualWAN {
    param([string]$ambiente_vwan)

    $VirtualWANs = Get-AzVirtualWan
    $report_vwan = @()

    foreach ($vwan in $VirtualWANs) {
        $info_vwan = "" | select ResourceGroup, Name, Location, ProvisioningState, Type, VpnGateways, ExpressRouteGateways, SecurityProviders, Subscription
        $info_vwan.ResourceGroup         = $vwan.ResourceGroupName
        $info_vwan.Name                  = $vwan.Name
        $info_vwan.Location              = $vwan.Location
        $info_vwan.ProvisioningState     = $vwan.ProvisioningState
        $info_vwan.Type                  = $vwan.Type
        $info_vwan.VpnGateways           = ($vwan.VpnGateways | ForEach-Object { $_.Id }) -join ", "
        $info_vwan.ExpressRouteGateways  = ($vwan.ExpressRouteGateways | ForEach-Object { $_.Id }) -join ", "
        $info_vwan.SecurityProviders     = ($vwan.SecurityProviders | ForEach-Object { $_.Name }) -join ", "
        $info_vwan.Subscription          = $ambiente_vwan
        $report_vwan += $info_vwan
    }

    $report_vwan | Export-Excel $xlfile -NoNumberConversion * -AutoSize -StartRow 1 -TableName "AzureVirtualWAN" -WorksheetName "Virtual WAN" -Append -KillExcel
    return $report_vwan
}



#########################################################


function reports_AzureFunctions {
    param([string]$ambiente_functions)

    $Functions = Get-AzFunctionApp
    $report_functions = @()

    foreach ($function in $Functions) {
        $info_function = "" | select ResourceGroup, Name, Location, AppServicePlan, Runtime, RuntimeVersion, OS, State, ProvisioningState, Subscription
        $info_function.ResourceGroup     = $function.ResourceGroup
        $info_function.Name              = $function.Name
        $info_function.Location          = $function.Location
        $info_function.AppServicePlan    = (Get-AzAppServicePlan -ResourceGroupName $function.ResourceGroup -Name $function.ServerFarmId.Split("/")[-1]).Name
        $info_function.Runtime           = $function.SiteConfig.PowerShellVersion ?? $function.SiteConfig.JavaVersion ?? $function.SiteConfig.PythonVersion ?? $function.SiteConfig.NodeVersion
        $info_function.RuntimeVersion    = $function.SiteConfig.FxVersion
        $info_function.OS                = $function.Kind -match "linux" ? "Linux" : "Windows"
        $info_function.State             = $function.State
        $info_function.ProvisioningState = $function.ProvisioningState
        $info_function.Subscription      = $ambiente_functions
        $report_functions += $info_function
    }

    $report_functions | Export-Excel $xlfile -NoNumberConversion * -AutoSize -StartRow 1 -TableName "AzureFunctions" -WorksheetName "Azure Functions" -Append -KillExcel
    return $report_functions
}

#########################################################

function reports_AzurePrivateEndpoint {
    param([string]$ambiente_pe)

    $PrivateEndpoints = Get-AzPrivateEndpoint
    $report_pe = @()

    foreach ($pe in $PrivateEndpoints) {
        $info_pe = "" | select ResourceGroup, Name, Location, VNet, Subnet, PrivateLinkService, ConnectionStatus, ProvisioningState, Subscription
        $info_pe.ResourceGroup      = $pe.ResourceGroupName
        $info_pe.Name               = $pe.Name
        $info_pe.Location           = $pe.Location
        $info_pe.VNet               = $pe.NetworkInterfaces[0].IpConfigurations[0].PrivateIpAddress
        $info_pe.Subnet             = $pe.Subnet.Id
        $info_pe.PrivateLinkService = $pe.PrivateLinkServiceConnections[0].PrivateLinkServiceId
        $info_pe.ConnectionStatus   = $pe.PrivateLinkServiceConnections[0].PrivateLinkServiceConnectionState.Status
        $info_pe.ProvisioningState  = $pe.ProvisioningState
        $info_pe.Subscription       = $ambiente_pe
        $report_pe += $info_pe
    }

    $report_pe | Export-Excel $xlfile -NoNumberConversion * -AutoSize -StartRow 1 -TableName "AzurePrivateEndpoints" -WorksheetName "Private Endpoints" -Append -KillExcel
    return $report_pe
}

#########################################################


function reports_AzureNSG {
    param([string]$ambiente_nsg)

    $NSGs = Get-AzNetworkSecurityGroup
    $report_nsg = @()

    foreach ($nsg in $NSGs) {
        $info_nsg = "" | select ResourceGroup, Name, Location, ProvisioningState, AssociatedSubnets, AssociatedNICs, Subscription
        $info_nsg.ResourceGroup     = $nsg.ResourceGroupName
        $info_nsg.Name              = $nsg.Name
        $info_nsg.Location          = $nsg.Location
        $info_nsg.ProvisioningState = $nsg.ProvisioningState
        $info_nsg.AssociatedSubnets = ($nsg.Subnets | ForEach-Object { $_.Id }) -join ", "
        $info_nsg.AssociatedNICs    = ($nsg.NetworkInterfaces | ForEach-Object { $_.Id }) -join ", "
        $info_nsg.Subscription      = $ambiente_nsg
        $report_nsg += $info_nsg
    }

    $report_nsg | Export-Excel $xlfile -NoNumberConversion * -AutoSize -StartRow 1 -TableName "AzureNSG" -WorksheetName "Network Security Groups" -Append -KillExcel
    return $report_nsg
}

#########################################################

function reports_AzureBastion {
    param([string]$ambiente_bastion)

    $Bastions = Get-AzBastion
    $report_bastion = @()

    foreach ($bastion in $Bastions) {
        $info_bastion = "" | select ResourceGroup, Name, Location, Sku, ProvisioningState, VNet, IPConfigurations, Subscription
        $info_bastion.ResourceGroup     = $bastion.ResourceGroupName
        $info_bastion.Name              = $bastion.Name
        $info_bastion.Location          = $bastion.Location
        $info_bastion.Sku               = $bastion.Sku.Name
        $info_bastion.ProvisioningState = $bastion.ProvisioningState
        $info_bastion.VNet              = $bastion.VirtualNetwork.Id
        $info_bastion.IPConfigurations  = ($bastion.IpConfigurations | ForEach-Object { $_.PublicIpAddress.Id }) -join ", "
        $info_bastion.Subscription      = $ambiente_bastion
        $report_bastion += $info_bastion
    }

    $report_bastion | Export-Excel $xlfile -NoNumberConversion * -AutoSize -StartRow 1 -TableName "AzureBastion" -WorksheetName "Azure Bastion" -Append -KillExcel
    return $report_bastion
}


#########################################################


function reports_AzureExpressRoute {
    param([string]$ambiente_expressroute)

    $ExpressRoutes = Get-AzExpressRouteCircuit
    $report_expressroute = @()

    foreach ($er in $ExpressRoutes) {
        $info_er = "" | select ResourceGroup, Name, Location, SkuTier, SkuFamily, ServiceProvider, PeeringLocation, Bandwidth, ProvisioningState, Subscription
        $info_er.ResourceGroup     = $er.ResourceGroupName
        $info_er.Name              = $er.Name
        $info_er.Location          = $er.Location
        $info_er.SkuTier           = $er.Sku.Tier
        $info_er.SkuFamily         = $er.Sku.Family
        $info_er.ServiceProvider   = $er.ServiceProviderProperties.ServiceProviderName
        $info_er.PeeringLocation   = $er.ServiceProviderProperties.PeeringLocation
        $info_er.Bandwidth         = "$($er.ServiceProviderProperties.BandwidthInMbps) Mbps"
        $info_er.ProvisioningState = $er.ProvisioningState
        $info_er.Subscription      = $ambiente_expressroute
        $report_expressroute += $info_er
    }

    $report_expressroute | Export-Excel $xlfile -NoNumberConversion * -AutoSize -StartRow 1 -TableName "AzureExpressRoute" -WorksheetName "ExpressRoute" -Append -KillExcel
    return $report_expressroute
}


#########################################################

function reports_AzureWAF {
    param([string]$ambiente_waf)

    $WAFPolicies = Get-AzApplicationGatewayWebApplicationFirewallPolicy
    $report_waf = @()

    foreach ($waf in $WAFPolicies) {
        $info_waf = "" | select ResourceGroup, Name, Location, SkuName, Mode, RuleSet, State, AssociatedGateways, Subscription
        $info_waf.ResourceGroup      = $waf.ResourceGroupName
        $info_waf.Name               = $waf.Name
        $info_waf.Location           = $waf.Location
        $info_waf.SkuName            = $waf.Sku.Name
        $info_waf.Mode               = $waf.PolicySettings.Mode
        $info_waf.RuleSet            = $waf.ManagedRules.ManagedRuleSets.RuleSetType + " " + $waf.ManagedRules.ManagedRuleSets.RuleSetVersion
        $info_waf.State              = $waf.ProvisioningState
        $info_waf.AssociatedGateways = ($waf.ApplicationGateway | ForEach-Object { $_.Id }) -join ", "
        $info_waf.Subscription       = $ambiente_waf
        $report_waf += $info_waf
    }

    $report_waf | Export-Excel $xlfile -NoNumberConversion * -AutoSize -StartRow 1 -TableName "AzureWAF" -WorksheetName "Azure WAF" -Append -KillExcel
    return $report_waf
}


#########################################################


function reports_AzureFirewall {
    param([string]$ambiente_fw)

    $Firewalls = Get-AzFirewall
    $report_fw = @()

    foreach ($fw in $Firewalls) {
        $info_fw = "" | select ResourceGroup, Name, Location, SkuName, SkuTier, ProvisioningState, ThreatIntelMode, VirtualNetwork, IPConfigurations, Subscription
        $info_fw.ResourceGroup      = $fw.ResourceGroupName
        $info_fw.Name               = $fw.Name
        $info_fw.Location           = $fw.Location
        $info_fw.SkuName            = $fw.Sku.Name
        $info_fw.SkuTier            = $fw.Sku.Tier
        $info_fw.ProvisioningState  = $fw.ProvisioningState
        $info_fw.ThreatIntelMode    = $fw.ThreatIntelMode
        $info_fw.VirtualNetwork     = $fw.VirtualNetwork.Name
        $info_fw.IPConfigurations   = ($fw.IpConfigurations | ForEach-Object { $_.PrivateIPAddress }) -join ", "
        $info_fw.Subscription       = $ambiente_fw
        $report_fw += $info_fw
    }

    $report_fw | Export-Excel $xlfile -NoNumberConversion * -AutoSize -StartRow 1 -TableName "AzureFirewall" -WorksheetName "Azure Firewall" -Append -KillExcel
    return $report_fw
}

#########################################################

function reports_TrafficManager {
    param([string]$ambiente_tm)

    $TrafficManagers = Get-AzTrafficManagerProfile
    $report_tm = @()

    foreach ($tm in $TrafficManagers) {
        $info_tm = "" | select ResourceGroup, Name, Location, RoutingMethod, DnsName, MonitorProtocol, MonitorPort, MonitorPath, ProfileStatus, Subscription
        $info_tm.ResourceGroup   = $tm.ResourceGroupName
        $info_tm.Name            = $tm.Name
        $info_tm.Location        = $tm.Location
        $info_tm.RoutingMethod   = $tm.TrafficRoutingMethod
        $info_tm.DnsName         = $tm.DnsConfig.Fqdn
        $info_tm.MonitorProtocol = $tm.MonitorConfig.Protocol
        $info_tm.MonitorPort     = $tm.MonitorConfig.Port
        $info_tm.MonitorPath     = $tm.MonitorConfig.Path
        $info_tm.ProfileStatus   = $tm.ProfileStatus
        $info_tm.Subscription    = $ambiente_tm
        $report_tm += $info_tm
    }

    $report_tm | Export-Excel $xlfile -NoNumberConversion * -AutoSize -StartRow 1 -TableName "TrafficManager" -WorksheetName "Traffic Manager" -Append -KillExcel
    return $report_tm
}

#########################################################














