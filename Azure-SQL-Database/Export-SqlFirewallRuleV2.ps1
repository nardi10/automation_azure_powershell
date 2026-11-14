# List of subscription IDs to iterate over
$subscriptions = @(
    "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy"
    # Add more IDs as needed
)

# Output file path
$outputFile = "C:\Rule_Allow_DB_NEW_2024_09_04.csv"

# Add header to the file (only if it does not exist yet)
if (-not (Test-Path $outputFile)) {
    "SubscriptionId;ResourceGroupName;ServerName;StartIpAddress;EndIpAddress;FirewallRuleName" | Out-File $outputFile
}

# Loop over the subscriptions
foreach ($subId in $subscriptions) {
    Write-Host "Switching to subscription: $subId" -ForegroundColor Cyan
    Set-AzContext -SubscriptionId $subId | Out-Null

    # Get the SQL servers of the current subscription
    $servers = Get-AzSqlServer

    foreach ($server in $servers) {
        try {
            $rules = Get-AzSqlServerFirewallRule -ServerName $server.ServerName -ResourceGroupName $server.ResourceGroupName

            foreach ($rule in $rules) {
                # Skip default rule (optional)
                if ($rule.StartIpAddress -eq "0.0.0.0" -and $rule.EndIpAddress -eq "0.0.0.0") {
                    continue
                }

                $line = "$subId;$($server.ResourceGroupName);$($server.ServerName);$($rule.StartIpAddress);$($rule.EndIpAddress);$($rule.FirewallRuleName)"
                $line | Out-File $outputFile -Append
            }
        }
        catch {
            Write-Warning "Error getting rules for server $($server.ServerName) in group $($server.ResourceGroupName) in subscription $subId"
        }
    }
}
