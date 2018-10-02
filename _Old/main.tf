provider "azurerm" {}

# Config Resource Group (RG)
module "rg" {
  source    = "./modules/rg"
}

# Virtual Network (vNET) Subnet (SUB)
module "net" {
  source    = "./modules/net"
}

# Public IP (PUBIP)
module "pubip" {
  source    = "./modules/pubip"
}

# Network Security Group (NSG) 
module "nsg" {
  source    = "./modules/nsg"
}

# NIC
module "nic" {
  source    = "./modules/nic"
}

# Storage (STORE)
resource "azurerm_storage_account" "clt_store" {
    name                     = "${var.prefix}0${var.storeaccount[0]}"
    resource_group_name      = "${module.rg.rgname}"
    location                 = "${var.location}"
    account_replication_type = "${var.storeaccount[1]}"
    account_tier             = "${var.storeaccount[2]}"
    tags {
        environment          = "${var.tags[0]}"
    }
}

# VM Windows
resource "azurerm_virtual_machine" "clt_vm_w" {
    name                  = "${var.prefix}0${var.vm[0]}"
    location              = "${var.location}"
    resource_group_name   = "${module.rg.rgname}"
    network_interface_ids = ["${module.nic.nic_w}"]
    vm_size               = "${var.vm[1]}"
    tags {
        environment       = "${var.tags[0]}"
    }
    storage_image_reference {
        publisher         = "${var.storeimg[0]}"
        offer             = "${var.storeimg[1]}"
        sku               = "${var.storeimg[2]}"
        version           = "${var.storeimg[3]}"
    }
    storage_os_disk {
        name              = "${var.prefix}0${var.vm[0]}0${var.storeosdisk[0]}"
        caching           = "${var.storeosdisk[1]}"
        create_option     = "${var.storeosdisk[2]}"
        managed_disk_type = "${var.storeosdisk[3]}"
    }
    storage_data_disk {
        name              = "${var.prefix}0${var.vm[0]}0${var.storedatadisk[0]}"
        managed_disk_type = "${var.storedatadisk[1]}"
        create_option     = "${var.storedatadisk[2]}"
        lun               = "${var.storedatadisk[3]}"
        disk_size_gb      = "${var.storedatadisk[4]}"
    }
    os_profile {
        computer_name     = "${var.prefix}0${var.vm[0]}"
        admin_username    = "${var.vmprofile[0]}"
        admin_password    = "${var.vmprofile[1]}"
    }
    os_profile_windows_config {
        enable_automatic_upgrades = true
        provision_vm_agent        = true
    }
    boot_diagnostics {
        enabled = "false"
        storage_uri = ""
    }
}

# VM Linux
resource "azurerm_virtual_machine" "clt_vm_l" {
    name                  = "${var.prefix}0${var.vmlinux[0]}"
    location              = "${var.location}"
    resource_group_name   = "${module.rg.rgname}"
    network_interface_ids = ["${module.nic.nic_l}"]
    vm_size               = "${var.vmlinux[1]}"
    tags {
        environment       = "${var.tags[0]}"
    }
    storage_os_disk {
        name              = "${var.prefix}0${var.vmlinux[0]}0${var.storeosdisklinux[0]}"
        caching           = "${var.storeosdisklinux[1]}"
        create_option     = "${var.storeosdisklinux[2]}"
        managed_disk_type = "${var.storeosdisklinux[3]}"
    }
    storage_image_reference {
        publisher = "${var.storeimglinux[0]}"
        offer     = "${var.storeimglinux[1]}"
        sku       = "${var.storeimglinux[2]}"
        version   = "${var.storeimglinux[3]}"
    }
    os_profile {
        computer_name  = "${var.prefix}0${var.vmlinux[0]}"
        admin_username = "${var.vmprofilelinux[0]}"
        admin_password = "${var.vmprofilelinux[1]}"
    }
    os_profile_linux_config {
        disable_password_authentication = false
    }
    boot_diagnostics {
        enabled = "false"
        storage_uri = ""
    }
}

/*# VM to AD
resource "azurerm_virtual_machine_extension" "joindomain" {
    name = "JoinDomain"
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.clt_rg.name}"
    virtual_machine_name = "${var.prefix}0${var.vm[0]}"
    publisher = "Microsoft.Compute"
    type = "JsonADDomainExtension"
    type_handler_version = "1.3"
    settings = <<BASE_SETTINGS
    {
        "Name": "testdom.local",
        "User": "azureuser@testdom.local",
        "OUPath": "OU=azure,DC=testdom,DC=local",
        "Restart": "true",
        "Options": "3"
    }
    BASE_SETTINGS
    protected_settings = <<PROTECTED_SETTINGS
    {
        "Password": "Passw0rd1"
    }
    PROTECTED_SETTINGS
}*/
/*module "active-directory-domain" {
  source                        = "./modules/active-directory"
  #resource_group_name           = "${module.rg.rgname}"
  location                      = "${var.location}"
  prefix                        = "${var.prefix}"
  #subnet_id                     = "${module.net.subnetid}"
  active_directory_domain       = "${var.prefix}.local"
  active_directory_netbios_name = "${var.prefix}"
  admin_username                = "${var.admin_username[0]}"
  admin_password                = "${var.admin_username[1]}"
}


resource "null_resource" "wait-for-domain-to-provision" {
  provisioner "local-exec" {
    command = "sleep 720"
  }
  depends_on = ["azurerm_virtual_machine.clt_vm_w"]
}

resource "azurerm_virtual_machine_extension" "join-domain" {
  name                 = "${azurerm_virtual_machine.clt_vm_w.name}"
  location             = "${azurerm_virtual_machine.clt_vm_w.location}"
  resource_group_name  = "${module.rg.rgname}"
  virtual_machine_name = "${azurerm_virtual_machine.clt_vm_w.name}"
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"

  # NOTE: the `OUPath` field is intentionally blank, to put it in the Computers OU
  settings = <<SETTINGS
    {
        "Name": "${var.active_directory_domain}",
        "OUPath": "",
        "User": "${var.active_directory_domain}\\${var.active_directory_username[0]}",
        "Restart": "true",
        "Options": "3"
    }
SETTINGS

  protected_settings = <<SETTINGS
    {
        "Password": "${var.active_directory_username[1]}"
    }
SETTINGS

  depends_on = ["null_resource.wait-for-domain-to-provision"]
}*/