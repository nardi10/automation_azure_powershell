Param
(
  [Parameter (Mandatory= $true)]
  [String] $action
)

function login() {

$connectionName = "AzureRunAsConnection"
try
{
# Get the connection "AzureRunAsConnection "
$servicePrincipalConnection=Get-AutomationConnection -Name $connectionName

Add-AzAccount `
-ServicePrincipal `
-TenantId $servicePrincipalConnection.TenantId `
-ApplicationId $servicePrincipalConnection.ApplicationId `
-CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint

Write-Output "Successfully logged into Azure subscription using Az cmdlets..."
}

catch {
if (!$servicePrincipalConnection)
{
$ErrorMessage = "Connection $connectionName not found."
throw $ErrorMessage
} else{
Write-Error -Message $_.Exception
throw $_.Exception
}
}
}

login

if ( $AzureRMAccount -ne "") {
$Subs = @("YOUR SUBSCRIPTION")
    foreach($Sub in $Subs) {
    $SubscriptionName = Set-AzContext -SubscriptionName $Sub
    $SubscriptionName.Subscription


function start_stop () {

    $jobs = @()
    Write-Output "$action action selected"

    #Get all VMs that should be part of the Schedule:
    $VMs = Get-AzResource -ResourceType "Microsoft.Compute/VirtualMachines" -TagName "start-stop-teste" -TagValue "yes"

    foreach($VM in $VMs) {
       $VMObject = Get-AzVM -ResourceGroupName $VM.ResourceGroupName -Name $VM.Name -Status

           if ($action -eq "start") {
                Write-Output "Starting $($VM.Name)..."
                try {
                    $params = @($VM.ResourceGroupName, $VM.Name)
                    
 #                   $job = Start-Job -ScriptBlock {
#                        param($rg, $name)
                            Start-AzVM -ResourceGroupName $VM.ResourceGroupName -Name $VM.Name -NoWait
 #                   } -ArgumentList $params 
                    
 #                   $jobs = $jobs + $job
 #                   Write-Output $job
                } Catch {
                    Write-Error -Message $_.Exception
                    throw $_.Exception
                }
           } elseif ($action -eq "stop") {
                Write-Output "Stopping $($VM.Name)..."
                try {
                    $params = @($VM.ResourceGroupName, $VM.Name)
                    
                    #$job = Start-Job -ScriptBlock {
                        #param($rg, $name)
                            Stop-AzVM -ResourceGroupName $VM.ResourceGroupName -Name $VM.Name -Force -NoWait
                   # } -ArgumentList $params 
                    
                    #$jobs = $jobs + $job

                } Catch {
                    Write-Error -Message $_.Exception
                    throw $_.Exception
                }
           } else {
                Write-Warning "Parameter $action invalid. No action will be performed ..."
           }
    }
    # Wait for it all to complete
#    Wait-Job -Job $jobs
}

start_stop

    }
}


