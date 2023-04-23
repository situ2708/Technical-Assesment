# Create network interface
resource "azurerm_network_interface" "vm-nic" {
  count = 2
  name                = var.nic_names[count.index]
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.vm_subnet_ids[count.index]
    private_ip_address_allocation = var.private_ip_address_allocation
  }

  tags = var.tags
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nsg-association" {
  count = 2
  network_interface_id      = azurerm_network_interface.vm-nic[count.index].id
  network_security_group_id = var.nsg_ids[count.index]

  depends_on = [azurerm_network_interface.vm-nic]
}

# Create (and display) an SSH key
resource "tls_private_key" "vm_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


# Create Linux virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  for_each                        = var.vm_config
  name                            = each.key
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = each.value.vm_size
  admin_username                  = each.value.vm_admin_username
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.vm-nic[each.key].id]

  admin_ssh_key {
    username   = each.value.vm_admin_username
    public_key = tls_private_key.vm_ssh.public_key_openssh
  }

  os_disk {
    caching              = each.value.os_disk_caching
    storage_account_type = each.value.os_disk_storage_type
  }

  source_image_reference {
    publisher = each.value.source_image_publisher
    offer     = each.value.source_image_offer
    sku       = each.value.source_image_sku
    version   = each.value.source_image_version
  }

  tags = var.tags
  depends_on = [azurerm_network_interface.vm-nic]
}
