resource "azurerm_network_security_group" "dbnsg" {
  name                = var.db_nsg_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow_app_inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "8080"
    destination_port_range     = "3306"
    source_address_prefix      = azurerm_subnet.appsn.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.dbsn.address_prefixes[0]
    description                = "Allow 3306 from app subnet to db subnet"
  }

  security_rule {
    name                       = "deny_web_inbound"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = azurerm_subnet.websn.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.dbsn.address_prefixes[0]
    description                = "Deny all traffic from Web subnet to DB subnet"
  }
}

resource "azurerm_subnet_network_security_group_association" "db_sn_association" {
  subnet_id                 = azurerm_subnet.dbsn.id
  network_security_group_id = azurerm_network_security_group.dbnsg.id

}
