module "rg" {
  source    = "../rg"
}

module "nsg" {
  source    = "../nsg"
}

module "net" {
  source    = "../net"
}

resource "azurerm_public_ip" "clt_pubip_wad1" {
    name                         = "${var.prefix}0${var.publicipwad1[0]}"
    location                     = "${var.location}"
    resource_group_name          = "${module.rg.rgname}"
    public_ip_address_allocation = "${var.publicipwad1[1]}"
    tags {
        environment              = "${var.tags[0]}"
    }
}

resource "azurerm_network_interface" "clt_nic_wad1" {
    name                              = "${var.prefix}0${var.nicwad1[0]}"
    location                          = "${var.location}"
    resource_group_name               = "${module.rg.rgname}"
    network_security_group_id         = "${module.nsg.nsgaccesid}"
    ip_configuration {
        name                          = "${var.prefix}0${var.nicwad1[1]}"
        subnet_id                     = "${module.net.subnetid}"
        private_ip_address_allocation = "${var.nicwad1[2]}"
        public_ip_address_id          = "${azurerm_public_ip.clt_pubip_wad1.id}"
    }
    tags {
        environment                   = "${var.tags[0]}"
    }
}

resource "azurerm_virtual_machine" "clt_vm_wad1" {
    name                  = "${var.prefix}0${var.vmwad1[0]}"
    location              = "${var.location}"
    resource_group_name   = "${module.rg.rgname}"
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
        custom_data       = "${file("./modules/scripts/ad.ps1")}"
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