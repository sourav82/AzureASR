
$fabricspri = Get-AzRecoveryServicesAsrFabric -FriendlyName "UK South"
$fabricsrec = Get-AzRecoveryServicesAsrFabric -FriendlyName "UK West"

$containerPri = Get-AzRecoveryServicesAsrProtectionContainer -Fabric $fabricspri

$protectedContainers=Get-AzRecoveryServicesAsrReplicationProtectedItem -ProtectionContainer $containerPri

$group=""
Foreach ($item in $protectedContainers){
	if ($item.FriendlyName -eq "luksawa001"){
		$group="Algo"
	}else{
		$group="CC"
	}
	New-AzRecoveryServicesAsrRecoveryPlan -Name $group -PrimaryFabric $fabricspri -RecoveryFabric $fabricsrec -ReplicationProtectedItem $item
}

#New-AzRecoveryServicesAsrRecoveryPlan -Name $group -PrimaryFabric $fabricspri -RecoveryFabric $fabricsrec -ReplicationProtectedItem $item