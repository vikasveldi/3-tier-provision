resource "azurerm_network_interface" "appnic" {
  name                = var.appnic_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.appsn.id
    private_ip_address_allocation = "Dynamic"
  }
}