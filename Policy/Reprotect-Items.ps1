$fabricspri = Get-AzRecoveryServicesAsrFabric -FriendlyName "UK South"
$fabricsrec = Get-AzRecoveryServicesAsrFabric -FriendlyName "UK West"
$AzureNetworkID = "/subscriptions/e214bc97-a738-4d9b-9671-8444a7e1a720/resourceGroups/Spoke-ASR/providers/Microsoft.Network/virtualNetworks/Spoke-ASR-VNET"

$containerPri = Get-AzRecoveryServicesAsrProtectionContainer -Fabric $fabricspri

$protectedContainers=Get-AzRecoveryServicesAsrReplicationProtectedItem -ProtectionContainer $containerPri

$group=""
Foreach ($item in $protectedContainers){
	if ($item.FriendlyName -eq "luksawa001"){
		$group="Algo"
		$subnetName = "VmUKWSubnet"
	}else{
		$group="CC"
		$subnetName = "VmUKWSubnet"
	}
	Update-AzRecoveryServicesAsrProtectionDirection -ReplicationProtectedItem $item -Direction RecoveryToPrimary 
}
$recoveryPlan=Get-AzRecoveryServicesAsrRecoveryPlan -Name "Algo"
Update-AzRecoveryServicesAsrProtectionDirection -RecoveryPlan $recoveryPlan -Direction RecoveryToPrimary