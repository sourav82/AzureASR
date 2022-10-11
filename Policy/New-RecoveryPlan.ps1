$fabricspri = Get-AzRecoveryServicesAsrFabric -FriendlyName "West Europe"
$fabricsrec = Get-AzRecoveryServicesAsrFabric -FriendlyName "North Europe"

$containerPri = Get-AzRecoveryServicesAsrProtectionContainer -Fabric $fabricspri

$protectedContainers=Get-AzRecoveryServicesAsrReplicationProtectedItem -ProtectionContainer $containerPri

$AzureNetworkID = <Get Recovery VNET from variable group>

$group=""
Foreach ($item in $protectedContainers){
	if (($item.FriendlyName -eq "LAWEPGBA111") -or ($item.FriendlyName -eq "LAWEPAGM111") -or ($item.FriendlyName -eq "LAWEPDBO111") -or ($item.FriendlyName -eq "LAWEPLTM101") -or ($item.FriendlyName -eq "LAWEPJPTR111") -or ($item.FriendlyName -eq "LAWEPNGINX01") -or ($item.FriendlyName -eq "WAWEPA2R001")){
		$group="Algo"
		$subnetName = <Get subnet name from variable group for Algo>
	}else if (($item.FriendlyName -eq "LAWEPLQD001") … upto 10){
		$group="Liquidity"
		$subnetName = <Get subnet name from variable group for Liquidity>
	}else if ($item.FriendlyName -eq "WAWEPCC001"){
		$group="Collateral Calc"
		$subnetName = <Get subnet name from variable group for CC>
	}else if ($item.FriendlyName -eq "LAWEJEN111"){
		$group="DevOps"
		$subnetName = <Get subnet name from variable group for DevOps>
	}else if ($item.FriendlyName -eq "LAWEEMDM111"){
		$group="MDM"
		$subnetName = <Get subnet name from variable group for MDM>
	}
	Set-AzRecoveryServicesAsrReplicationProtectedItem -ReplicationProtectedItem $item -RecoveryNetworkId $AzureNetworkID -RecoveryNicSubnetName $subnetName
	
	New-AzRecoveryServicesAsrRecoveryPlan -Name $group -PrimaryFabric $fabricspri -RecoveryFabric $fabricsrec -ReplicationProtectedItem $item
}
