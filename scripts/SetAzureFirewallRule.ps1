# Taken from MS documentation: https://learn.microsoft.com/en-us/azure/devops/pipelines/targets/azure-sqldb?view=azure-devops&tabs=yaml
[CmdletBinding(DefaultParameterSetName = 'None')]
param
(
  [String] [Parameter(Mandatory = $true)] $ServerName,
  [String] [Parameter(Mandatory = $true)] $ResourceGroupName,
  [String] $FirewallRuleName = "AzureWebAppFirewall"
)
$agentIP = (New-Object net.webclient).downloadstring("https://api.ipify.org")
New-AzSqlServerFirewallRule -ResourceGroupName $ResourceGroupName -ServerName $ServerName -FirewallRuleName $FirewallRuleName -StartIPAddress $agentIp -EndIPAddress $agentIP
