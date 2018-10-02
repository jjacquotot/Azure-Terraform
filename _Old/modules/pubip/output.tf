output "pubiplinuxid" {
  description = "Catch Public IP ID VM Linux"
  value       = "${azurerm_public_ip.clt_pubip.id}"
}

output "pubipwindowsid" {
  description = "Catch Public IP ID VM Linux"
  value       = "${azurerm_public_ip.clt_pubiplinux.id}"
}