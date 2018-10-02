module "rg" {
  source    = "../rg"
}

module "nsg" {
  source    = "../nsg"
}

module "net" {
  source    = "../net"
}

resource "azurerm_public_ip" "clt_pubip_l1" {
    name                         = "${var.prefix}0${var.publicipl1[0]}"
    location                     = "${var.location}"
    resource_group_name          = "${module.rg.rgname}"
    public_ip_address_allocation = "${var.publicipl1[1]}"
    tags {
        environment              = "${var.tags[0]}"
    }
}
resource "azurerm_network_interface" "clt_nic_l1" {
    name                              = "${var.prefix}0${var.nicl1[0]}"
    location                          = "${var.location}"
    resource_group_name               = "${module.rg.rgname}"
    network_security_group_id         = "${module.nsg.nsgaccesid}"
    ip_configuration {
        name                          = "${var.prefix}0${var.nicl1[1]}"
        subnet_id                     = "${module.net.subnetid}"
        private_ip_address_allocation = "${var.nicl1[2]}"
        public_ip_address_id          = "${azurerm_public_ip.clt_pubip_l1.id}"
    }
    tags {
        environment                   = "${var.tags[0]}"
    }
}

resource "azurerm_virtual_machine" "clt_vm_l1" {
    name                  = "${var.prefix}0${var.vml1[0]}"
    location              = "${var.location}"
    resource_group_name   = "${module.rg.rgname}"
    network_interface_ids = ["${azurerm_network_interface.clt_nic_l1.id}"]
    vm_size               = "${var.vml1[1]}"
    tags {
        environment       = "${var.tags[0]}"
    }
    storage_os_disk {
        name              = "${var.prefix}0${var.vml1[0]}0${var.storeosdiskl1[0]}"
        caching           = "${var.storeosdiskl1[1]}"
        create_option     = "${var.storeosdiskl1[2]}"
        managed_disk_type = "${var.storeosdiskl1[3]}"
    }
    storage_image_reference {
        publisher = "${var.storeimgl1[0]}"
        offer     = "${var.storeimgl1[1]}"
        sku       = "${var.storeimgl1[2]}"
        version   = "${var.storeimgl1[3]}"
    }
    os_profile {
        computer_name  = "${var.prefix}0${var.vml1[0]}"
        admin_username = "${var.vmprofilel1[0]}"
        admin_password = "${var.vmprofilel1[1]}"
    }
    os_profile_linux_config {
        disable_password_authentication = false
    }
    boot_diagnostics {
        enabled = "false"
        storage_uri = ""
    }
}