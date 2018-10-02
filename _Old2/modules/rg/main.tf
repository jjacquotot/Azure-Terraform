resource "azurerm_resource_group" "clt_rg" {
    name                = "${var.prefix}0${var.resource_group_name}"
    location            = "${var.location}"
    tags {
        environment     = "${var.tags[0]}"
    }
}