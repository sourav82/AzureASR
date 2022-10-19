$vnetAlgo=Get-AzVirtualNetwork -Name Bermuda-VNET -ResourceGroupName BermudaRG
Add-AzVirtualNetworkPeering -Name Bermuda2Algo -VirtualNetwork $vnetAlgo -RemoteVirtualNetworkId "/subscriptions/700d1aab-224e-4b10-8bdc-8d0835ba5213/resourceGroups/AlgoRG/providers/Microsoft.Network/virtualNetworks/AWA-VNET" -AllowForwardedTraffic
