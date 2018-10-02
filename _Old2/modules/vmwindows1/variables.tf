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

variable "publicipw1" {
  description = "Config Public IP : Public IP Name, Allocation Type"
  type        = "list"
  default     = ["publicipw1", "dynamic"]
}

variable "nicw1" {
  description = "Config NIC : Name NIC, IP Name, IP Allocation Type"
  type        = "list"
  default     = ["nic", "confipnic", "dynamic"]
}

variable "vmw1" {
  description = "Config VM : Name VM, Size VM"
  type        = "list"
  default     = ["vmwindows", "Standard_A0"]
}

variable "storeimgw1" {
  description = "Config Image : Publisher, Offer, sku, version https://docs.microsoft.com/en-us/azure/virtual-machines/windows/cli-ps-findimage"
  type        = "list"
  default     = ["MicrosoftWindowsServer", "WindowsServer", "2012-R2-Datacenter", "latest"]
}

variable "storeosdiskw1" {
  description = "Config OS DIsk : name, caching, create_option, managed_disk_type"
  type        = "list"
  default     = ["oswindows", "ReadWrite", "FromImage", "Standard_LRS"]
}

variable "storedatadiskw1" {
  description = "Config DATA Disk : name, managed_disk_type, create_option, lun, disk_size_gb"
  type        = "list"
  default     = ["data", "Standard_LRS", "Empty", "0", "1023"]
}

variable "vmprofilew1" {
  description = "Config VM Profile : admin_username, admin_password, sku, version"
  type        = "list"
  default     = ["administrateur", "Passw0rd1"]
}