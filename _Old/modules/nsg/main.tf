module "rg" {
  source    = "../rg"
}

resource "azurerm_network_security_group" "clt_nsg_acces" {
  name                = "${var.prefix}0${var.nsg_name}"
  location            = "${var.location}"
  resource_group_name = "${module.rg.rgname}"

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