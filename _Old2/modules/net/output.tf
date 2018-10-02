output "subnetid" {
  description = "Catch Subnet ID"
  value       = "${azurerm_subnet.clt_sub.id}"
}

output "subnetname" {
  description = "Catch Subnet Name"
  value       = "${azurerm_subnet.clt_sub.name}"
}