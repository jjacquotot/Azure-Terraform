output "nic_w" {
  description = "Catch NIC ID VM Windows"
  value       = "${azurerm_network_interface.clt_nic.id}"
}

output "nic_l" {
  description = "Catch NIC ID VM Linux"
  value       = "${azurerm_network_interface.clt_niclinux.id}"
}

output "nic_dc" {
  description = "Catch NIC ID VM DC"
  value       = "${azurerm_network_interface.clt_nicad.id}"
}