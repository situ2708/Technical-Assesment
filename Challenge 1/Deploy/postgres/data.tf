data "azurerm_virtual_network" "postgresql-vnet" {
  name                = "vnet-finance-demo-eastus"
  resource_group_name = "demo-rg"
}

data "azurerm_subnet" "app-subnet" {
  name                 = "App_subnet"
  virtual_network_name = "vnet-finance-demo-eastus"
  resource_group_name  = "demo-rg"
}
