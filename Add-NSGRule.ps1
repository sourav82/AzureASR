$RGname="AlgoRG"
$port=1099
$rulename="bermudaawarule"
$nsgname="AWA-NSG"

$nsg = Get-AzNetworkSecurityGroup -Name $nsgname -ResourceGroupName $RGname
$nsg | Add-AzNetworkSecurityRuleConfig -Name $rulename -Description "Allow AWA port from Bermuda" -Access Allow `
    -Protocol * -Direction Inbound -Priority 120 -SourceAddressPrefix "10.21.99.0/24" -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange $port

# Update the NSG.
$nsg | Set-AzNetworkSecurityGroup
