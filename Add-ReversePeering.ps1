$securePassword = echo $env:plainPassword | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $env:ApplicationId, $securePassword
Connect-AzAccount -ServicePrincipal -TenantId $env:TenantIdBermuda -Credential $Credential
$bermudaVnet=Get-AzVirtualNetwork -Name Bermuda-VNET -ResourceGroupName BermudaRG
Add-AzVirtualNetworkPeering -Name Bermuda2Algo -VirtualNetwork $bermudaVnet -RemoteVirtualNetworkId "/subscriptions/700d1aab-224e-4b10-8bdc-8d0835ba5213/resourceGroups/AlgoRG/providers/Microsoft.Network/virtualNetworks/AWA-VNET" -AllowForwardedTraffic
