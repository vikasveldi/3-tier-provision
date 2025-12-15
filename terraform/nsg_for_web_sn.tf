resource "azurerm_network_security_group" "webnsg" {
  name                = var.web_nsg_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow_ssh_inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "<MY-IP-ADDRESS>"
    destination_address_prefix = azurerm_subnet.websn.address_prefixes[0]
    description                = "Allow SSH from any source to any destination"
  }

  security_rule {
    name                       = "allow_web_inbound"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = azurerm_subnet.websn.address_prefixes[0]
    description                = "Allow HTTP from any to web subnet 10.0.1.0/24"
  }
}

resource "azurerm_subnet_network_security_group_association" "web_sn_association" {
  subnet_id                 = azurerm_subnet.websn.id
  network_security_group_id = azurerm_network_security_group.webnsg.id

}
