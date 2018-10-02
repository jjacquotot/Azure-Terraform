variable "prefix" {
  description = "Prefix for all resources."
  default     = "clt"
}

variable "tags" {
  description = "Tags."
  type        = "list"
  default     = ["DEMO", "QUAL"]
}

variable "resource_group_name" {
  description = "Ressource Group Name."
  default     = "rg"
}

variable "location" {
  description = "The location/region https://azure.microsoft.com/regions"
  default     = "West Europe"
}

variable "publicip" {
  description = "Config Public IP : Public IP Name, Allocation Type"
  type        = "list"
  default     = ["publicip", "dynamic"]
}

variable "publiciplinux" {
  description = "Config Public IP : Public IP Name, Allocation Type"
  type        = "list"
  default     = ["publiciplinux", "dynamic"]
}