data "azurerm_virtual_network" "vnet" {
  name                = "vnet-finance-demo-eastus"
  resource_group_name = "demo-rg"
}
data "azurerm_subnet" "web_vm" {
  name                 = "Web_subnet"
  virtual_network_name = "vnet-finance-demo-eastus"
  resource_group_name  = "demo-rg"
}

data "azurerm_subnet" "app_vm" {
  name                 = "App_subnet"
  virtual_network_name = "vnet-finance-demo-eastus"
  resource_group_name  = "demo-rg"
}

data "azurerm_network_security_group" "web-vm" {
  name                = "nsg-web"
  resource_group_name = "demo-rg"
}

data "azurerm_network_security_group" "app-vm" {
  name                = "nsg-app"
  resource_group_name = "demo-rg"
}
