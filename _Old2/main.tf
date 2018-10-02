provider "azurerm" {}


# Config Resource Group (RG)
module "rg" {
  source    = "./modules/rg"
}

# Virtual Network (vNET) Subnet (SUB)
module "net" {
  source    = "./modules/net"
}

# Network Security Group (NSG) 
module "nsg" {
  source    = "./modules/nsg"
}

# Storage (STORE)
module "storage" {
  source    = "./modules/storage"
}

# VM Linux
module "vmlinux1" {
  source    = "./modules/vmlinux1"
}


# VM Windows AD
module "vmwindowsad1" {
  source    = "./modules/vmwindowsad1"
}

# VM Windows
module "vmwindows1" {
  source    = "./modules/vmwindows1"
}




