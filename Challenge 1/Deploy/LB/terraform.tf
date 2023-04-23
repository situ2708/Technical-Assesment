module "lb" {
  source                 = "../../Modules/lb"
  lb_name                = "demo" 
  location               = "eastus"
  resource_group_name    = "demo-rg"
  backend_vm_nic         = "web-vm"
  backend_vm_ip_config   = "internal"
  tags = {
    "environment"         = "demo"
    "BU"                  = "finance"
  }
}  
  
terraform {
  backend "azurerm" {
    resource_group_name  = "demo-rg"
    storage_account_name = "tfstate"
    container_name       = "demo"
    key                  = "lb.demo.tfstate"
  }
 }

provider "azurerm" {
  features {}
}
