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

variable "nic" {
  description = "Config NIC : Name NIC, IP Name, IP Allocation Type"
  type        = "list"
  default     = ["nic", "confipnic", "dynamic"]
}

variable "niclinux" {
  description = "Config NIC : Name NIC, IP Name, IP Allocation Type"
  type        = "list"
  default     = ["niclinux", "confipniclinux", "dynamic"]
}

variable "nicad" {
  description = "Config NIC : Name NIC, IP Name, IP Allocation Type"
  type        = "list"
  default     = ["nicad", "confipnicad", "Static", "10.0.1.10"]
}