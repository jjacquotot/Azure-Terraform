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
  default     = "East US"
}

variable "vnet" {
  description = "Config vNET : vNET Name, vNET Space"
  type = "list"
  default = ["vnet", "10.0.0.0/16"]
}

variable "subnet" {
  description = "Config Subnet : Subnet Name, Subnet Space"
  type        = "list"
  default     = ["subnet", "10.0.1.0/24"]
}