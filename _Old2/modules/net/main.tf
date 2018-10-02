module "rg" {
  source    = "../rg"
}
resource "azurerm_virtual_network" "clt_vnet" {
    name                = "${var.prefix}0${var.vnet[0]}"
    address_space       = ["${var.vnet[1]}"]
    location            = "${var.location}"
    resource_group_name = "${module.rg.rgname}"
    tags {
        environment     = "${var.tags[0]}"
    }
}

resource "azurerm_subnet" "clt_sub" {
    name                 = "${var.prefix}0${var.subnet[0]}"
    resource_group_name  = "${module.rg.rgname}"
    virtual_network_name = "${azurerm_virtual_network.clt_vnet.name}"
    address_prefix       = "${var.subnet[1]}"
}