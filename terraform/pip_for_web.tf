resource "azurerm_public_ip" "webpip" {
  name                = var.webpip_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
}