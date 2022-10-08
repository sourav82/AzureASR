variable "sourceRegion" {
  default     = "uksouth"
  description = "Source location of the VMs."
}

variable "targetRegion" {
  default     = "ukwest"
  description = "Target location of the VMs."
}

variable "targetResourceGroupId" {
  default     = "/subscriptions/e214bc97-a738-4d9b-9671-8444a7e1a720/resourceGroups/Bermuda-UKW"
  description = "Target resource group id"
}

variable "vaultResourceGroupId" {
  default     = "/subscriptions/e214bc97-a738-4d9b-9671-8444a7e1a720/resourceGroups/Spoke-UKW"
  description = "Vault resource group id"
}

variable "vaultId" {
  default     = "/subscriptions/e214bc97-a738-4d9b-9671-8444a7e1a720/resourceGroups/Spoke-UKW/providers/Microsoft.RecoveryServices/vaults/RSV-UKW-Spoke-01"
  description = "Vault id"
}

variable "recoveryNetworkId" {
  default     = "/subscriptions/e214bc97-a738-4d9b-9671-8444a7e1a720/resourceGroups/Bermuda-UKW/providers/Microsoft.Network/virtualNetworks/Bermuda-UKW-ASR"
  description = "Recovery network Id"
}

variable "cacheStorageAccountId" {
  default     = "/subscriptions/e214bc97-a738-4d9b-9671-8444a7e1a720/resourceGroups/BermudaRG/providers/Microsoft.Storage/storageAccounts/bermudastorageasr"
  description = "Cache storage"
}

variable "cust_scope" {
  default     = "/subscriptions/e214bc97-a738-4d9b-9671-8444a7e1a720/resourceGroups/BermudaRG"
  description = "Custom scope"
}
variable "vaultName" {
  default     = "RSV-UKW-Spoke-01"
  description = "Vault name"
}