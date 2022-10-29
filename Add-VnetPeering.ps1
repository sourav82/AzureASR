$vnetAlgo=Get-AzVirtualNetwork -Name AWA-VNET -ResourceGroupName AlgoRG
echo $env:plainPassword
$securePassword = echo $env:plainPassword | ConvertTo-SecureString -AsPlainText -Force
echo $securePassword 
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $env:ApplicationId, $securePassword

echo $env:TenantIdAlgo
Connect-AzAccount -ServicePrincipal -TenantId $env:TenantIdBermuda -Credential $Credential
Set-AzContext -TenantId $env:TenantIdAlgo -SubscriptionId $env:SubscriptionIdAlgo
Add-AzVirtualNetworkPeering -Name Algo2Bermuda -VirtualNetwork $vnetAlgo -RemoteVirtualNetworkId "/subscriptions/e214bc97-a738-4d9b-9671-8444a7e1a720/resourceGroups/BermudaRG/providers/Microsoft.Network/virtualNetworks/Bermuda-VNET" -AllowForwardedTraffic

