$AzureNetworkID = <Get Recovery VNET from variable group>

$algoPlan=Get-AzRecoveryServicesAsrRecoveryPlan -Name “Algo”
$liqPlan=Get-AzRecoveryServicesAsrRecoveryPlan -Name “Liquidity”
$ccPlan=Get-AzRecoveryServicesAsrRecoveryPlan -Name “Liquidity”
$devopsPlan=Get-AzRecoveryServicesAsrRecoveryPlan -Name “DevOps”
$mdmPlan=Get-AzRecoveryServicesAsrRecoveryPlan -Name “MDM”
Start-AzRecoveryServicesAsrTestFailoverJob -RecoveryPlan $algoPlan -Direction PrimaryToRecovery -AzureVMNetworkId $AzureNetworkID
Start-AzRecoveryServicesAsrTestFailoverJob -RecoveryPlan $liqPlan -Direction PrimaryToRecovery -AzureVMNetworkId $AzureNetworkID
Start-AzRecoveryServicesAsrTestFailoverJob -RecoveryPlan $ccPlan -Direction PrimaryToRecovery -AzureVMNetworkId $AzureNetworkID
Start-AzRecoveryServicesAsrTestFailoverJob -RecoveryPlan $mdmPlan -Direction PrimaryToRecovery -AzureVMNetworkId $AzureNetworkID
