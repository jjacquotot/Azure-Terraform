# Prefix  Client ----------------------------------------------------------------------------------------------------
variable "prefix" {
  description = "Prefix for all resources."
  default     = "clt"
}

# Ressource Group  Client ---------------------------------------------------------------------------------------------------
variable "resource_group_name" {
  description = "Resources Group Name"
  default     = "rg"
}

# Tag Environnements ----------------------------------------------------------------------------------------------------
variable "tags" {
  description = "Tags."
  type        = "list"
  default     = ["DEMO", "QUAL"]
}

# Location  ----------------------------------------------------------------------------------------------------
variable "location" {
  description = "The location/region https://azure.microsoft.com/regions"
  default     = "East US"
}

# vNET  ----------------------------------------------------------------------------------------------------
variable "vnet" {
  description = "Config vNET : vNET Name, vNET Space"
  type = "list"
  default = ["vnet", "10.0.0.0/16"]
}

# Subnet  ----------------------------------------------------------------------------------------------------
variable "subnet" {
  description = "Config Subnet : Subnet Name, Subnet Space"
  type        = "list"
  default     = ["subnet", "10.0.1.0/24"]
}

# Network Security Group Name  ----------------------------------------------------------------------------------------------------
variable "nsg_name" {
  description = "Network Security Group Name"
  default     = "nsg"
}

# Storage Account  ----------------------------------------------------------------------------------------------------
variable "storeaccount" {
  description = "Config Storage Account : name, account_replication_type, account_tier"
  type        = "list"
  default     = ["storageaccount", "LRS", "Standard"]
}

# Config VM Linux1  ----------------------------------------------------------------------------------------------------
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

# Config VM WindowsAD1  ----------------------------------------------------------------------------------------------------
variable "publicipwad1" {
  description = "Config Public IP : Public IP Name, Allocation Type"
  type        = "list"
  default     = ["publicipwad1", "dynamic"]
}

variable "nicwad1" {
  description = "Config NIC : Name NIC, IP Name, IP Allocation Type, IP Allocation"
  type        = "list"
  default     = ["nicwad1", "confipnic", "static", "10.0.1.5"]
}

variable "vmwad1" {
  description = "Config VM : Name VM, Size VM"
  type        = "list"
  default     = ["vmwad1", "Standard_A2"]
}

variable "storeimgwad1" {
  description = "Config Image : Publisher, Offer, sku, version https://docs.microsoft.com/en-us/azure/virtual-machines/windows/cli-ps-findimage"
  type        = "list"
  default     = ["MicrosoftWindowsServer", "WindowsServer", "2012-R2-Datacenter", "latest"]
}

variable "storeosdiskwad1" {
  description = "Config OS DIsk : name, caching, create_option, managed_disk_type"
  type        = "list"
  default     = ["oswindows", "ReadWrite", "FromImage", "Standard_LRS"]
}

variable "storedatadiskwad1" {
  description = "Config DATA Disk : name, managed_disk_type, create_option, lun, disk_size_gb"
  type        = "list"
  default     = ["data", "Standard_LRS", "Empty", "0", "1023"]
}

variable "vmprofilewad1" {
  description = "Config VM Profile : admin_username, admin_password, sku, version"
  type        = "list"
  default     = ["administrateur", "Passw0rd1"]
}

# Config VM Windows1  ----------------------------------------------------------------------------------------------------
variable "publicipw1" {
  description = "Config Public IP : Public IP Name, Allocation Type"
  type        = "list"
  default     = ["publicipw1", "dynamic"]
}

variable "nicw1" {
  description = "Config NIC : Name NIC, IP Name, IP Allocation Type"
  type        = "list"
  default     = ["nicw1", "confipnic", "static", "10.0.1.4"]
}

variable "vmw1" {
  description = "Config VM : Name VM, Size VM"
  type        = "list"
  default     = ["vmw1", "Standard_A0"]
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