output "storagename" {
  description = "Catch Storage Name"
  value       = "${azurerm_storage_account.clt_store.name}"
}