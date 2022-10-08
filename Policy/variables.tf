variable "sourceRegion" {
  default     = "uksouth"
  description = "Source location of the VMs."
}

variable "targetRegion" {
  default     = "ukwest"
  description = "Target location of the VMs."
}

variable "storageResourceGroupName" {
  default     = "Spoke"
  description = "Vault resource group name"
}

variable "targetResourceGroupId" {
  default     = "/subscriptions/e214bc97-a738-4d9b-9671-8444a7e1a720/resourceGroups/Spoke-ASR"
  description = "Target resource group id"
}

variable "vaultResourceGroupId" {
  default     = "/subscriptions/e214bc97-a738-4d9b-9671-8444a7e1a720/resourceGroups/Spoke-ASR"
  description = "Vault resource group id"
}

variable "vaultResourceGroupName" {
  default     = "Spoke-ASR"
  description = "Vault resource group name"
}

variable "vaultId" {
  default     = "/subscriptions/e214bc97-a738-4d9b-9671-8444a7e1a720/resourceGroups/Spoke-ASR/providers/Microsoft.RecoveryServices/vaults/RSV-UKW-DR"
  description = "Vault id"
}

variable "recoveryNetworkId" {
  default     = "/subscriptions/e214bc97-a738-4d9b-9671-8444a7e1a720/resourceGroups/Spoke-ASR/providers/Microsoft.Network/virtualNetworks/Spoke-ASR-VNET"
  description = "Recovery network Id"
}

variable "cacheStorageAccountId" {
  default     = "/subscriptions/e214bc97-a738-4d9b-9671-8444a7e1a720/resourceGroups/Spoke/providers/Microsoft.Storage/storageAccounts/bermudastorageasr"
  description = "Cache storage"
}

variable "cust_scope" {
  default     = "/subscriptions/e214bc97-a738-4d9b-9671-8444a7e1a720/resourceGroups/Spoke"
  description = "Custom scope"
}

variable "vaultName" {
  default     = "RSV-UKW-DR"
  description = "Vault name"
}

variable "storageName" {
  default     = "sacuksnprdii0001"
  description = "Vault name"
}