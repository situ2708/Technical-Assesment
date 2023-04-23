module "vnet" {
  source              = "../../Modules/network"
  location            = "eastus"
  resource_group_name = "demo-rg"
  environment         = "demo"
  division            = "finance"
  service             = "vnet"
  vnet_name           = "vnet-finance-demo-eastus"
  address_space       = ["10.0.0.0/16"]
  subnets = {
    "Web_subnet" = { range = "10.0.1.0/24", service_endpoints = [] }
    "App_subnet" = { range = "10.0.2.0/24", service_endpoints = ["Microsoft.Sql"] }
    "DB_subnet"  = { range = "10.0.3.0/24", service_endpoints = [] }
  }
  network_security_groups = ["nsg-web", "nsg-app", "nsg-db"]
  nsg_rules_web = {
    "http" = {
      name                       = "http-inbound"
      priority                   = "201"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "80"
      destination_port_range     = "80"
      source_address_prefixes    = ["AzureLoadBalancer"]
      destination_address_prefix = "10.0.1.0/24"
    },
    "ssh" = {
      name                       = "ssh"
      priority                   = "202"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefixes    = ["VirtualNetwork"]
      destination_address_prefix = "10.0.1.0/24"
    },
  }

  nsg_rules_app = {
    "app-inbound" = {
      name                       = "app-inbound-1"
      priority                   = "201"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "8081"
      source_address_prefixes    = ["10.0.1.0/24"]
      destination_address_prefix = "10.0.2.0/24"
    },
    "app-inbound-2" = {
      name                       = "app-inbound-2"
      priority                   = "204"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "8080"
      source_address_prefixes    = ["10.0.1.0/24"]
      destination_address_prefix = "10.0.2.0/24"
    },
    "app-ssh" = {
      name                       = "app-vm-ssh"
      priority                   = "204"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefixes    = ["VirtualNetwork"]
      destination_address_prefix = "10.0.2.0/24"
    }
  }

  nsg_rules_db = {
    "db-inbound" = {
      name                       = "db-inbound"
      priority                   = "201"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5432"
      source_address_prefixes    = ["10.0.2.0/24"]
      destination_address_prefix = "10.0.3.0/24"
    }
  } 
    tags = {
      "environment" = "demo"
      "BU"          = "finance"
    }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "demo-rg"
    storage_account_name = "tfstate"
    container_name       = "demo"
    key                  = "vnet.demo.tfstate"
  }
}

provider "azurerm" {
  features {}
}