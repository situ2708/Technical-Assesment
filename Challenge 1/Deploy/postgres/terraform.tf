module "postgresql" {
  source                        = "../../Modules/postgresql"
  location                      = "eastus"
  resource_group_name           = "demo-rg"
  environment                   = "demo"
  division                      = "finance"
  service                       = "psql"
  postgresql_admin              = "adminuser"
  sku_name                      = "GP_Gen5_4"
  postgresql_version            = "11"
  storage_mb                    = "102400"
  backup_retention              = "7"
  public_access_enabled         = "false"
  ssl_enforce                   = "true"
  ssl_version                   = "TLS1_2"
  vnet_id                       = "${data.azurerm_virtual_network.postgresql-vnet.id}"
  app_subnet_id                = "${data.azurerm_subnet.app-subnet.id}"
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
    key                  = "postgresql.demo.tfstate"
  }
}

provider "azurerm" {
  features {}
}
