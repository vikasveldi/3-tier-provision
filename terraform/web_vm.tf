# Create virtual machine
resource "azurerm_linux_virtual_machine" "webvm" {
  name                  = var.webvm_name
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.webnic.id]
  size                  = "Standard_B2s"

  os_disk {
    name                 = var.webvm_osdisk_name
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = "webserver"
  admin_username                  = var.vm_username
  disable_password_authentication = false
  admin_password                  = var.vm_password
}