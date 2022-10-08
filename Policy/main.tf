resource "azurerm_storage_account" "spokestorage" {
  name                     = var.storageName
  resource_group_name      = var.storageResourceGroupName
  location                 = var.sourceRegion
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_site_recovery_replication_policy" "asr-policy" {
  name                                                 = "asr-policy"
  resource_group_name                                  = var.vaultResourceGroupName
  recovery_vault_name                                  = var.vaultName
  recovery_point_retention_in_minutes                  = 7 * 24 * 60
  application_consistent_snapshot_frequency_in_minutes = 4 * 60
  depends_on = [azurerm_storage_account.spokestorage]
}



resource "azurerm_resource_group_policy_assignment" "allvms" { 
 name = "all-vm-asr" 
 identity { type = "SystemAssigned" }
 location = var.sourceRegion
 resource_group_id = var.cust_scope 
 policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ac34a73f-9fa5-4067-9247-a3ecae514468" 
 description = "Virtual machines without disaster recovery configurations are vulnerable to outages and other disruptions. If the virtual machine does not already have disaster recovery configured, this would initiate the same by enabling replication using preset configurations to facilitate business continuity.  You can optionally include/exclude virtual machines containing a specified tag to control the scope of assignment. To learn more about disaster recovery, visit https://aka.ms/asr-doc." 
 display_name = "Configure ASR for all VMs in the scope" 
 depends_on = [azurerm_site_recovery_replication_policy.asr-policy]
 parameters = jsonencode (
 {
	"sourceRegion": {
		"value": var.sourceRegion
	},
	"targetRegion": {
		"value": var.targetRegion
	},
	"targetResourceGroupId": {
		"value": var.targetResourceGroupId
	},
	"vaultResourceGroupId": {
		"value": var.vaultResourceGroupId
	},
	"vaultId": {
		"value": var.vaultId
	},
	"recoveryNetworkId": {
		"value": var.recoveryNetworkId
	},
	"cacheStorageAccountId": {
		"value": azurerm_storage_account.spokestorage.id
	},
	"effect": {
		"value": "DeployIfNotExists"
	},
 })
}

resource "azurerm_role_assignment" "roleAssignementLogAnalyticsContributor1" {
  scope                = var.cust_scope
  role_definition_name = "Log Analytics Contributor"
  principal_id         = azurerm_resource_group_policy_assignment.allvms.identity[0].principal_id
  depends_on = [azurerm_resource_group_policy_assignment.allvms]
}

resource "azurerm_role_assignment" "roleAssignementLogAnalyticsContributor" {
  scope                = "/subscriptions/e214bc97-a738-4d9b-9671-8444a7e1a720/resourceGroups/Spoke-ASR"
  role_definition_name = "Contributor"
  principal_id         = azurerm_resource_group_policy_assignment.allvms.identity[0].principal_id
  depends_on = [azurerm_resource_group_policy_assignment.allvms]
}

#resource "azurerm_role_assignment" "roleAssignementLogAnalyticsContributor2" {
#  scope                = "/subscriptions/e214bc97-a738-4d9b-9671-8444a7e1a720/resourceGroups/Bermuda-UKW"
#  role_definition_name = "Contributor"
#  principal_id         = azurerm_resource_group_policy_assignment.allvms.identity[0].principal_id
#  depends_on = [azurerm_resource_group_policy_assignment.allvms]
#}

resource "azurerm_resource_group_policy_remediation" "allvms-remediate" {
  name                 = "asr-policy-remediation"
  resource_group_id    = var.cust_scope 
  policy_assignment_id = azurerm_resource_group_policy_assignment.allvms.id
  location_filters     = ["UK South"]
  depends_on = [azurerm_resource_group_policy_assignment.allvms, azurerm_role_assignment.roleAssignementLogAnalyticsContributor, azurerm_role_assignment.roleAssignementLogAnalyticsContributor1]#, azurerm_role_assignment.roleAssignementLogAnalyticsContributor2]
}