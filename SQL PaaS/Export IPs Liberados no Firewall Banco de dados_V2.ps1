# Lista de IDs de assinaturas para percorrer
$subscriptions = @(
    "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy"
    # Adicione mais IDs conforme necessário
)

# Caminho do arquivo de saída
$outputFile = "C:\Rule_Allow_DB_NEW_2024_09_04.csv"

# Adiciona cabeçalho ao arquivo (apenas se ainda não existir)
if (-not (Test-Path $outputFile)) {
    "SubscriptionId;ResourceGroupName;ServerName;StartIpAddress;EndIpAddress;FirewallRuleName" | Out-File $outputFile
}

# Loop nas assinaturas
foreach ($subId in $subscriptions) {
    Write-Host "Switching to subscription: $subId" -ForegroundColor Cyan
    Set-AzContext -SubscriptionId $subId | Out-Null

    # Pega os servidores SQL da assinatura atual
    $servers = Get-AzSqlServer

    foreach ($server in $servers) {
        try {
            $rules = Get-AzSqlServerFirewallRule -ServerName $server.ServerName -ResourceGroupName $server.ResourceGroupName

            foreach ($rule in $rules) {
                # Ignora regra padrão (opcional)
                if ($rule.StartIpAddress -eq "0.0.0.0" -and $rule.EndIpAddress -eq "0.0.0.0") {
                    continue
                }

                $line = "$subId;$($server.ResourceGroupName);$($server.ServerName);$($rule.StartIpAddress);$($rule.EndIpAddress);$($rule.FirewallRuleName)"
                $line | Out-File $outputFile -Append
            }
        }
        catch {
            Write-Warning "Erro ao obter regras para o servidor $($server.ServerName) no grupo $($server.ResourceGroupName) na assinatura $subId"
        }
    }
}
