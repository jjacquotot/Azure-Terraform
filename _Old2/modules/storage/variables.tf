variable "prefix" {
  description = "Prefix for all resources."
  default     = "clt"
}

variable "tags" {
  description = "Tags."
  type        = "list"
  default     = ["DEMO", "QUAL"]
}

variable "location" {
  description = "The location/region https://azure.microsoft.com/regions"
  default     = "East US"
}

variable "storeaccount" {
  description = "Config Storage Account : name, account_replication_type, account_tier"
  type        = "list"
  default     = ["storageaccount", "LRS", "Standard"]
}