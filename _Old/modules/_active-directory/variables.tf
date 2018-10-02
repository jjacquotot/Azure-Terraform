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
  default     = "West Europe"
}

variable "active_directory_domain" {
  description = "The name of the Active Directory domain, for example `consoto.local`"
  default = "cltdom.local"
}

variable "active_directory_netbios_name" {
  description = "The netbios name of the Active Directory domain, for example `consoto`"
  default = "cltdom"
}

variable "admin_username" {
  description = "The username associated with the local administrator account on the virtual machine"
  default = "administrateur"
}

variable "admin_password" {
  description = "The password associated with the local administrator account on the virtual machine"
  default = "PassW0rd1234"
}

