output "nsgaccesid" {
  description = "Catch Network Security Group ID"
  value       = "${azurerm_network_security_group.clt_nsg_acces.id}"
}
