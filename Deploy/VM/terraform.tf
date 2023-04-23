module "vm" {
  source                        = "../../Modules/compute"
  location                      = "eastus"
  resource_group_name           = "demo-rg"
  vm_subnet_ids                = ["${data.azurerm_subnet.web_vm.id}", "${data.azurerm_subnet.app_vm.id}"]
  nic_names                     = ["web-vm", "app-vm"] 
  private_ip_address_allocation = "Dynamic"
  nsg_ids                        = ["${data.azurerm_network_security_group.web-vm.id}", "${data.azurerm_network_security_group.app-vm.id}"]
  vm_config = {
    "web-vm"  = {
      vm_size = "Standard_D2as_v4"
      vm_admin_username = "azureuser"
      os_disk_caching = "ReadWrite"
      os_disk_storage_type = "Premium_LRS"
      source_image_publisher = "RedHat"
      source_image_offer = "RHEL"
      source_image_sku = "82gen2"
      source_image_version = "latest"
    }
    "app-vm"  = {
      vm_size = "Standard_D2as_v4"
      vm_admin_username = "azureuser"
      os_disk_caching = "ReadWrite"
      os_disk_storage_type = "Premium_LRS"
      source_image_publisher = "RedHat"
      source_image_offer = "RHEL"
      source_image_sku = "82gen2"
      source_image_version = "latest"
    }
  }
  tags = {
    "environment"         = "demo"
    "BU"                  = "finance"
  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "demo-rg"
    storage_account_name = "tfstate"
    container_name       = "demo-state"
    key                  = "vm.demo.tfstate"
  }
}

provider "azurerm" {
  features {}
}
