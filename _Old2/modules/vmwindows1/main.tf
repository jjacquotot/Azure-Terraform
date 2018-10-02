module "rg" {
  source    = "../rg"
}

module "nsg" {
  source    = "../nsg"
}

module "net" {
  source    = "../net"
}

resource "azurerm_public_ip" "clt_pubip_w1" {
    name                         = "${var.prefix}0${var.publicipw1[0]}"
    location                     = "${var.location}"
    resource_group_name          = "${module.rg.rgname}"
    public_ip_address_allocation = "${var.publicipw1[1]}"
    tags {
        environment              = "${var.tags[0]}"
    }
}

resource "azurerm_network_interface" "clt_nic_w1" {
    name                              = "${var.prefix}0${var.nicw1[0]}"
    location                          = "${var.location}"
    resource_group_name               = "${module.rg.rgname}"
    network_security_group_id         = "${module.nsg.nsgaccesid}"
    ip_configuration {
        name                          = "${var.prefix}0${var.nicw1[1]}"
        subnet_id                     = "${module.net.subnetid}"
        private_ip_address_allocation = "${var.nicw1[2]}"
        public_ip_address_id          = "${azurerm_public_ip.clt_pubip_w1.id}"
    }
    tags {
        environment                   = "${var.tags[0]}"
    }
}

resource "azurerm_virtual_machine" "clt_vm_w" {
    name                  = "${var.prefix}0${var.vmw1[0]}"
    location              = "${var.location}"
    resource_group_name   = "${module.rg.rgname}"
    network_interface_ids = ["${azurerm_network_interface.clt_nic_w1.id}"]
    vm_size               = "${var.vmw1[1]}"
    tags {
        environment       = "${var.tags[0]}"
    }
    storage_image_reference {
        publisher         = "${var.storeimgw1[0]}"
        offer             = "${var.storeimgw1[1]}"
        sku               = "${var.storeimgw1[2]}"
        version           = "${var.storeimgw1[3]}"
    }
    storage_os_disk {
        name              = "${var.prefix}0${var.vmw1[0]}0${var.storeosdiskw1[0]}"
        caching           = "${var.storeosdiskw1[1]}"
        create_option     = "${var.storeosdiskw1[2]}"
        managed_disk_type = "${var.storeosdiskw1[3]}"
    }
    storage_data_disk {
        name              = "${var.prefix}0${var.vmw1[0]}0${var.storedatadiskw1[0]}"
        managed_disk_type = "${var.storedatadiskw1[1]}"
        create_option     = "${var.storedatadiskw1[2]}"
        lun               = "${var.storedatadiskw1[3]}"
        disk_size_gb      = "${var.storedatadiskw1[4]}"
    }
    os_profile {
        computer_name     = "${var.prefix}0${var.vmw1[0]}"
        admin_username    = "${var.vmprofilew1[0]}"
        admin_password    = "${var.vmprofilew1[1]}"
        custom_data       = "${file("./modules/scripts/add-domain.ps1")}"
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