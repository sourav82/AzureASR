$vnetAlgo=Get-AzVirtualNetwork -Name AWA-VNET -ResourceGroupName AlgoRG
Add-AzVirtualNetworkPeering -Name Algo2Bermuda -VirtualNetwork $vnetAlgo -RemoteVirtualNetworkId "/subscriptions/700d1aab-224e-4b10-8bdc-8d0835ba5213/resourceGroups/BermudaRG/providers/Microsoft.Network/virtualNetworks/Bermuda-VNET" -AllowForwardedTraffic
