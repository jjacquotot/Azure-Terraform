module "rg" {
  source    = "../rg"
}
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