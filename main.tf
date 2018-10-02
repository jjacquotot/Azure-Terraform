provider "azurerm" {}


# Resource Group (RG) ----------------------------------------------------------------------------------------------------
resource "azurerm_resource_group" "clt_rg" {
    name                = "${var.prefix}0${var.resource_group_name}"
    location            = "${var.location}"
    tags {
        environment     = "${var.tags[0]}"
    }
}

# Virtual Network (vNET) Subnet (SUB) ----------------------------------------------------------------------------------------------------
# Config vNET
resource "azurerm_virtual_network" "clt_vnet" {
    name                = "${var.prefix}0${var.vnet[0]}"
    address_space       = ["${var.vnet[1]}"]
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.clt_rg.name}"
    tags {
        environment     = "${var.tags[0]}"
    }
}

# Config SUBNET
resource "azurerm_subnet" "clt_sub" {
    name                 = "${var.prefix}0${var.subnet[0]}"
    resource_group_name  = "${azurerm_resource_group.clt_rg.name}"
    virtual_network_name = "${azurerm_virtual_network.clt_vnet.name}"
    address_prefix       = "${var.subnet[1]}"
}

# Network Security Group (NSG) ----------------------------------------------------------------------------------------------------
resource "azurerm_network_security_group" "clt_nsg_acces" {
  name                  = "${var.prefix}0${var.nsg_name}"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.clt_rg.name}"
    tags {
        environment     = "${var.tags[0]}"
    }
  security_rule {
    name                       = "${var.prefix}SSH"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                        = "${var.prefix}0TSE"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "3389"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }
}

# Storage (STORE) ----------------------------------------------------------------------------------------------------
resource "azurerm_storage_account" "clt_store" {
    name                     = "${var.prefix}0${var.storeaccount[0]}"
    resource_group_name      = "${azurerm_resource_group.clt_rg.name}"
    location                 = "${var.location}"
    account_replication_type = "${var.storeaccount[1]}"
    account_tier             = "${var.storeaccount[2]}"
    tags {
        environment          = "${var.tags[0]}"
    }
}

# VM Windows AD  (Public IP / NIC / VM) ----------------------------------------------------------------------------------------------------
# Config Public IP WindowsAD1
resource "azurerm_public_ip" "clt_pubip_wad1" {
    name                         = "${var.prefix}0${var.publicipwad1[0]}"
    location                     = "${var.location}"
    resource_group_name          = "${azurerm_resource_group.clt_rg.name}"
    public_ip_address_allocation = "${var.publicipwad1[1]}"
    tags {
        environment              = "${var.tags[0]}"
    }
}

# Config VM NIC WindowsAD1
resource "azurerm_network_interface" "clt_nic_wad1" {
    name                              = "${var.prefix}0${var.nicwad1[0]}"
    location                          = "${var.location}"
    resource_group_name               = "${azurerm_resource_group.clt_rg.name}"
    network_security_group_id         = "${azurerm_network_security_group.clt_nsg_acces.id}"
    ip_configuration {
        name                          = "${var.prefix}0${var.nicwad1[1]}"
        subnet_id                     = "${azurerm_subnet.clt_sub.id}"
        private_ip_address_allocation = "${var.nicwad1[2]}"
        private_ip_address            = "${var.nicwad1[3]}"  
        public_ip_address_id          = "${azurerm_public_ip.clt_pubip_wad1.id}"
    }
    tags {
        environment                   = "${var.tags[0]}"
    }
}

# Config VM WindowsAD1
resource "azurerm_virtual_machine" "clt_vm_wad1" {
    name                  = "${var.prefix}0${var.vmwad1[0]}"
    location              = "${var.location}"
    resource_group_name   = "${azurerm_resource_group.clt_rg.name}"
    network_interface_ids = ["${azurerm_network_interface.clt_nic_wad1.id}"]
    vm_size               = "${var.vmwad1[1]}"
    tags {
        environment       = "${var.tags[0]}"
    }
    storage_image_reference {
        publisher         = "${var.storeimgwad1[0]}"
        offer             = "${var.storeimgwad1[1]}"
        sku               = "${var.storeimgwad1[2]}"
        version           = "${var.storeimgwad1[3]}"
    }
    storage_os_disk {
        name              = "${var.prefix}0${var.vmwad1[0]}0${var.storeosdiskwad1[0]}"
        caching           = "${var.storeosdiskwad1[1]}"
        create_option     = "${var.storeosdiskwad1[2]}"
        managed_disk_type = "${var.storeosdiskwad1[3]}"
    }
    storage_data_disk {
        name              = "${var.prefix}0${var.vmwad1[0]}0${var.storedatadiskwad1[0]}"
        managed_disk_type = "${var.storedatadiskwad1[1]}"
        create_option     = "${var.storedatadiskwad1[2]}"
        lun               = "${var.storedatadiskwad1[3]}"
        disk_size_gb      = "${var.storedatadiskwad1[4]}"
    }
    os_profile {
        computer_name     = "${var.prefix}0${var.vmwad1[0]}"
        admin_username    = "${var.vmprofilewad1[0]}"
        admin_password    = "${var.vmprofilewad1[1]}"
    }
    os_profile_windows_config {
        enable_automatic_upgrades = true
        provision_vm_agent        = true
    }
    boot_diagnostics {
        enabled             = "false"
        storage_uri         = ""
    }
}

# Custom script install & configuration AD
resource "azurerm_virtual_machine_extension" "deployad" {
  name                 = "${var.prefix}0deployad"
  location             = "${var.location}"
  resource_group_name  = "${azurerm_resource_group.clt_rg.name}"
  virtual_machine_name = "${var.prefix}0${var.vmwad1[0]}"
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.8"
  depends_on           = ["azurerm_virtual_machine.clt_vm_wad1"]

  settings = <<SETTINGS
    { 
    "fileUris": [ 
        "https://raw.githubusercontent.com/jjacquotot/Azure-Terraform/master/Scripts/ad.ps1" 
    ], 
    "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File ad.ps1" 
    } 
    SETTINGS
    tags {
    environment = "${var.tags[0]}"
  }
}

# VM Windows ----------------------------------------------------------------------------------------------------
# Config Public IP Windows1
resource "azurerm_public_ip" "clt_pubip_w1" {
    name                         = "${var.prefix}0${var.publicipw1[0]}"
    location                     = "${var.location}"
    resource_group_name          = "${azurerm_resource_group.clt_rg.name}"
    public_ip_address_allocation = "${var.publicipw1[1]}"
    tags {
        environment              = "${var.tags[0]}"
    }
}

# Config VM NIC Windows1
resource "azurerm_network_interface" "clt_nic_w1" {
    name                              = "${var.prefix}0${var.nicw1[0]}"
    location                          = "${var.location}"
    resource_group_name               = "${azurerm_resource_group.clt_rg.name}"
    network_security_group_id         = "${azurerm_network_security_group.clt_nsg_acces.id}"
    dns_servers                       = ["${var.nicwad1[3]}"] # Force DNS with the Ip Adress of the VM AD for this VM join VM AD 
    ip_configuration {
        name                          = "${var.prefix}0${var.nicw1[1]}"
        subnet_id                     = "${azurerm_subnet.clt_sub.id}"
        private_ip_address_allocation = "${var.nicw1[2]}"
        private_ip_address            = "${var.nicw1[3]}"  
        public_ip_address_id          = "${azurerm_public_ip.clt_pubip_w1.id}"
    }
    tags {
        environment                   = "${var.tags[0]}"
    }
}

# Config VM Windows1
resource "azurerm_virtual_machine" "clt_vm_w1" {
    name                    = "${var.prefix}0${var.vmw1[0]}"
    location                = "${var.location}"
    resource_group_name     = "${azurerm_resource_group.clt_rg.name}"
    network_interface_ids   = ["${azurerm_network_interface.clt_nic_w1.id}"]
    vm_size                 = "${var.vmw1[1]}"
    tags {
        environment         = "${var.tags[0]}"
    }
    storage_image_reference {
        publisher           = "${var.storeimgw1[0]}"
        offer               = "${var.storeimgw1[1]}"
        sku                 = "${var.storeimgw1[2]}"
        version             = "${var.storeimgw1[3]}"
    }
    storage_os_disk {
        name                = "${var.prefix}0${var.vmw1[0]}0${var.storeosdiskw1[0]}"
        caching             = "${var.storeosdiskw1[1]}"
        create_option       = "${var.storeosdiskw1[2]}"
        managed_disk_type   = "${var.storeosdiskw1[3]}"
    }
    storage_data_disk {
        name                = "${var.prefix}0${var.vmw1[0]}0${var.storedatadiskw1[0]}"
        managed_disk_type   = "${var.storedatadiskw1[1]}"
        create_option       = "${var.storedatadiskw1[2]}"
        lun                 = "${var.storedatadiskw1[3]}"
        disk_size_gb        = "${var.storedatadiskw1[4]}"
    }
    os_profile {
        computer_name       = "${var.prefix}0${var.vmw1[0]}"
        admin_username      = "${var.vmprofilew1[0]}"
        admin_password      = "${var.vmprofilew1[1]}"
    }
    os_profile_windows_config {
        enable_automatic_upgrades = true
        provision_vm_agent        = true
    }
    boot_diagnostics {
        enabled             = "false"
        storage_uri         = ""
    }
}

# Join VM Windows1 to AD VM WindowsAD1
resource "azurerm_virtual_machine_extension" "joinad" {
  name                 = "${var.prefix}0joinad"
  location             = "${var.location}"
  resource_group_name  = "${azurerm_resource_group.clt_rg.name}"
  virtual_machine_name = "${var.prefix}0${var.vmw1[0]}"
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.8"
  depends_on           = ["azurerm_virtual_machine.clt_vm_wad1" , "azurerm_virtual_machine.clt_vm_w1" , "azurerm_virtual_machine_extension.deployad"] # This actions temporize this job because the VM + VM AD + DeployAD may be create before

  settings = <<SETTINGS
    { 
    "fileUris": [ 
        "https://raw.githubusercontent.com/jjacquotot/Azure-Terraform/master/Scripts/add-domain.ps1" 
    ], 
    "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File add-domain.ps1" 
    } 
    SETTINGS
    tags {
    environment = "${var.tags[0]}"
  }
}

/*
# VM Linux (Public IP / NIC / VM) ----------------------------------------------------------------------------------------------------
# Config Public IP Linux1
resource "azurerm_public_ip" "clt_pubip_l1" {
    name                         = "${var.prefix}0${var.publicipl1[0]}"
    location                     = "${var.location}"
    resource_group_name          = "${azurerm_resource_group.clt_rg.name}"
    public_ip_address_allocation = "${var.publicipl1[1]}"
    tags {
        environment              = "${var.tags[0]}"
    }
}

# Config VM NIC Linux1
resource "azurerm_network_interface" "clt_nic_l1" {
    name                              = "${var.prefix}0${var.nicl1[0]}"
    location                          = "${var.location}"
    resource_group_name               = "${azurerm_resource_group.clt_rg.name}"
    network_security_group_id         = "${azurerm_network_security_group.clt_nsg_acces.id}"
    ip_configuration {
        name                          = "${var.prefix}0${var.nicl1[1]}"
        subnet_id                     = "${azurerm_subnet.clt_sub.id}"
        private_ip_address_allocation = "${var.nicl1[2]}"
        public_ip_address_id          = "${azurerm_public_ip.clt_pubip_l1.id}"
    }
    tags {
        environment                   = "${var.tags[0]}"
    }
}

# Config VM Linux1
resource "azurerm_virtual_machine" "clt_vm_l1" {
    name                    = "${var.prefix}0${var.vml1[0]}"
    location                = "${var.location}"
    resource_group_name     = "${azurerm_resource_group.clt_rg.name}"
    network_interface_ids   = ["${azurerm_network_interface.clt_nic_l1.id}"]
    vm_size                 = "${var.vml1[1]}"
    tags {
        environment         = "${var.tags[0]}"
    }
    storage_os_disk {
        name                = "${var.prefix}0${var.vml1[0]}"
        caching             = "${var.storeosdiskl1[1]}"
        create_option       = "${var.storeosdiskl1[2]}"
        managed_disk_type   = "${var.storeosdiskl1[3]}"
    }
    storage_image_reference {
        publisher           = "${var.storeimgl1[0]}"
        offer               = "${var.storeimgl1[1]}"
        sku                 = "${var.storeimgl1[2]}"
        version             = "${var.storeimgl1[3]}"
    }
    os_profile {
        computer_name       = "${var.prefix}0${var.vml1[0]}"
        admin_username      = "${var.vmprofilel1[0]}"
        admin_password      = "${var.vmprofilel1[1]}"
    }
    os_profile_linux_config {
        disable_password_authentication = false
    }
    boot_diagnostics {
        enabled             = "false"
        storage_uri         = ""
    }
}
*/