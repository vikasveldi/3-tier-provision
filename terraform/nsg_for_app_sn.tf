resource "azurerm_network_security_group" "appnsg" {
  name                = var.app_nsg_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow_web_inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = azurerm_subnet.websn.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.appsn.address_prefixes[0]
    description                = "Allow 8080 from web subnet to app subnet"
  }
}

resource "azurerm_subnet_network_security_group_association" "app_sn_association" {
  subnet_id                 = azurerm_subnet.appsn.id
  network_security_group_id = azurerm_network_security_group.appnsg.id
}
