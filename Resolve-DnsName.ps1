$privateEndpoints = @(
    "YOUR_FQDN",
)
 
foreach ($endpoint in $privateEndpoints) {
    Resolve-DnsName $endpoint
}