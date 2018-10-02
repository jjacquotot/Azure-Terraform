
module "rg" {
  source    = "../rg"
}

module "nsg" {
  source    = "../nsg"
}

module "net" {
  source    = "../net"
}

module "pubip" {
  source    = "../pubip"
}

resource "azurerm_network_interface" "clt_nic" {
    name                              = "${var.prefix}0${var.nic[0]}"
    location                          = "${var.location}"
    resource_group_name               = "${module.rg.rgname}"
    network_security_group_id         = "${module.nsg.nsgaccesid}"
    ip_configuration {
        name                          = "${var.prefix}0${var.nic[1]}"
        subnet_id                     = "${module.net.subnetid}"
        private_ip_address_allocation = "${var.nic[2]}"
        public_ip_address_id          = "${module.pubip.pubipwindowsid}"
    }
    tags {
        environment                   = "${var.tags[0]}"
    }
}

resource "azurerm_network_interface" "clt_niclinux" {
    name                              = "${var.prefix}0${var.niclinux[0]}"
    location                          = "${var.location}"
    resource_group_name               = "${module.rg.rgname}"
    network_security_group_id         = "${module.nsg.nsgaccesid}"
    ip_configuration {
        name                          = "${var.prefix}0${var.niclinux[1]}"
        subnet_id                     = "${module.net.subnetid}"
        private_ip_address_allocation = "${var.niclinux[2]}"
        public_ip_address_id          = "${module.pubip.pubiplinuxid}"
    }
    tags {
        environment                   = "${var.tags[0]}"
    }
}

resource "azurerm_network_interface" "clt_nicad" {
  name                    = "${var.prefix}0${var.nicad[0]}"
  location                = "${var.location}"
  resource_group_name     = "${module.rg.rgname}"
  internal_dns_name_label = "${var.prefix}-dc"

  ip_configuration {
    name                          = "${var.prefix}0${var.nicad[1]}"
    subnet_id                     = "${module.net.subnetid}"
    private_ip_address_allocation = "${var.nicad[2]}"
    private_ip_address            = "${var.nicad[3]}"
  }
}