output "application_gateway_id" {
    description = "ID of app gateway"
    value = azurerm_application_gateway.network.id
}