resource "azurerm_site_recovery_fabric" "primary" {
  name                = "primary-fabric"
  resource_group_name = var.vaultResourceGroupName
  recovery_vault_name = var.vaultName
  location            = var.sourceRegion
}

resource "azurerm_site_recovery_fabric" "secondary" {
  name                = "secondary-fabric"
  resource_group_name = var.vaultResourceGroupName
  recovery_vault_name = var.vaultName
  location            = var.targetRegion
}

resource "azurerm_site_recovery_protection_container" "primary" {
  name                 = "primary-protection-container"
  resource_group_name  = var.vaultResourceGroupName
  recovery_vault_name  = var.vaultName
  recovery_fabric_name = var.sourceRegion
}

resource "azurerm_site_recovery_protection_container" "secondary" {
  name                 = "secondary-protection-container"
  resource_group_name  = var.vaultResourceGroupName
  recovery_vault_name  = var.vaultName
  recovery_fabric_name = var.targetRegion
}



resource "azurerm_site_recovery_replication_policy" "asr-policy" {
  name                                                 = "asr-policy"
  resource_group_name                                  = var.vaultResourceGroupName
  recovery_vault_name                                  = var.vaultName
  recovery_point_retention_in_minutes                  = 7 * 24 * 60
  application_consistent_snapshot_frequency_in_minutes = 12 * 60
  depends_on = [azurerm_storage_account.spokestorage]
}

resource "azurerm_site_recovery_protection_container_mapping" "container-mapping" {
  name                                      = "container-mapping"
  resource_group_name                       = var.vaultResourceGroupName
  recovery_vault_name                       = var.vaultName
  recovery_fabric_name                      = azurerm_site_recovery_fabric.primary.name
  recovery_source_protection_container_name = azurerm_site_recovery_protection_container.primary.name
  recovery_target_protection_container_id   = azurerm_site_recovery_protection_container.secondary.id
  recovery_replication_policy_id            = azurerm_site_recovery_replication_policy.asr-policy.id
}
