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

variable "publicipl1" {
  description = "Config Public IP : Public IP Name, Allocation Type"
  type        = "list"
  default     = ["publicipl1", "dynamic"]
}

variable "nicl1" {
  description = "Config NIC : Name NIC, IP Name, IP Allocation Type"
  type        = "list"
  default     = ["nicl1", "confipniclinux", "dynamic"]
}

variable "vml1" {
  description = "Config VM : Name VM, Size VM"
  type        = "list"
  default     = ["vml1", "Standard_DS1_v2"]
}

variable "storeimgl1" {
  description = "Config Image : Publisher, Offer, sku, version"
  type        = "list"
  default     = ["Canonical", "UbuntuServer", "16.04.0-LTS", "latest"]
}

variable "storeosdiskl1" {
  description = "Config OS DIsk : name, caching, create_option, managed_disk_type"
  type        = "list"
  default     = ["oslinux", "ReadWrite", "FromImage", "Premium_LRS"]
}

variable "vmprofilel1" {
  description = "Config VM Profile : admin_username, admin_password, sku, version"
  type        = "list"
  default     = ["jonathan", "Passw0rd1"]
}