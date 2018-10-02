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

variable "admin_usernamead" {
  description = "The username of the administrator account for both the local accounts, and Active Directory accounts. Example: `myexampleadmin`"
  default = "cltadmin"
}

variable "admin_passwordad" {
  description = "The password of the administrator account for both the local accounts, and Active Directory accounts. Needs to comply with the Windows Password Policy. Example: `PassW0rd1234!`"
  default = "PassW0rd1234!"
}

variable "vm" {
  description = "Config VM : Name VM, Size VM"
  type        = "list"
  default     = ["vmwindows", "Standard_A0"]
}

variable "vmlinux" {
  description = "Config VM : Name VM, Size VM"
  type        = "list"
  default     = ["vmlinux", "Standard_DS1_v2"]
}

variable "storeaccount" {
  description = "Config Storage Account : name, account_replication_type, account_tier"
  type        = "list"
  default     = ["storageaccount", "LRS", "Standard"]
}

variable "storeimg" {
  description = "Config Image : Publisher, Offer, sku, version https://docs.microsoft.com/en-us/azure/virtual-machines/windows/cli-ps-findimage"
  type        = "list"
  default     = ["MicrosoftWindowsServer", "WindowsServer", "2012-R2-Datacenter", "latest"]
}

variable "storeimglinux" {
  description = "Config Image : Publisher, Offer, sku, version"
  type        = "list"
  default     = ["Canonical", "UbuntuServer", "16.04.0-LTS", "latest"]
}

variable "storeosdisk" {
  description = "Config OS DIsk : name, caching, create_option, managed_disk_type"
  type        = "list"
  default     = ["oswindows", "ReadWrite", "FromImage", "Standard_LRS"]
}

variable "storeosdisklinux" {
  description = "Config OS DIsk : name, caching, create_option, managed_disk_type"
  type        = "list"
  default     = ["oslinux", "ReadWrite", "FromImage", "Premium_LRS"]
}

variable "storedatadisk" {
  description = "Config DATA Disk : name, managed_disk_type, create_option, lun, disk_size_gb"
  type        = "list"
  default     = ["data", "Standard_LRS", "Empty", "0", "1023"]
}

variable "vmprofile" {
  description = "Config VM Profile : admin_username, admin_password, sku, version"
  type        = "list"
  default     = ["administrateur", "Passw0rd1"]
}

variable "vmprofilelinux" {
  description = "Config VM Profile : admin_username, admin_password, sku, version"
  type        = "list"
  default     = ["jonathan", "Passw0rd1"]
}

/*variable "active_directory_domain" {
  description = "The name of the Active Directory domain, for example `consoto.local`"
  default = "cltdom.local"
}

variable "active_directory_username" {
  description = "The username of an account with permissions to bind machines to the Active Directory Domain"
  type = "list"
  default = ["cltadmin", "Passw0rd1"]
}

variable "admin_username" {
  description = "The username associated with the local administrator account on the virtual machine"
  type = "list"
  default = ["administrateur", "Passw0rd2"]
}*/
