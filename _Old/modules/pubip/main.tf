module "rg" {
  source    = "../rg"
}

resource "azurerm_public_ip" "clt_pubip" {
    name                         = "${var.prefix}0${var.publicip[0]}"
    location                     = "${var.location}"
    resource_group_name          = "${module.rg.rgname}"
    public_ip_address_allocation = "${var.publicip[1]}"
    tags {
        environment              = "${var.tags[0]}"
    }
}

resource "azurerm_public_ip" "clt_pubiplinux" {
    name                         = "${var.prefix}0${var.publiciplinux[0]}"
    location                     = "${var.location}"
    resource_group_name          = "${module.rg.rgname}"
    public_ip_address_allocation = "${var.publiciplinux[1]}"
    tags {
        environment              = "${var.tags[0]}"
    }
}