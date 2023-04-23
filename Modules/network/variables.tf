variable "location" {
  description = "Default region for deployed resources"
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Target environment for the resource"
  type        = string
}

variable "division" {
  description = "Name of the division"
  type        = string
  default     = "ccs"
}

variable "service" {
  description = "Name of the Azure service"
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name to be imported"
  type        = string
  default     = null
}

variable "tags" {
  description = "Any tags that should be present on the resources"
  type        = map(string)
  default     = {}
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "Address space for network"
  type        = list(string)
}

variable "subnets" {
  description = "Subnets names and IP ranges for subnetwork"
  type        = map(object({
    range             = string
    service_endpoints = list(string) # Possible value: Microsoft.AzureCosmosDB, Microsoft.KeyVault, Microsoft.Storage and Microsoft.Sql
  }))
}

variable "network_security_groups" {
  description = "network_security_groups"
  type        = list(string)
}

variable "nsg_rules_web" {
  description = "Network security group set"
  type = map(object({
    name                       = string
    priority                   = string
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefixes    = list(string)
    destination_address_prefix = string
    #nsg_list                   = list(string)
  }))
}  
  
  
variable "nsg_rules_app" {
  description = "Network security group set"
  type = map(object({
    name                       = string
    priority                   = string
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefixes    = list(string)
    destination_address_prefix = string
    #nsg_list                   = list(string)
  }))
} 
variable "nsg_rules_db" {
  description = "Network security group set"
  type = map(object({
    name                       = string
    priority                   = string
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefixes    = list(string)
    destination_address_prefix = string
    #nsg_list                   = list(string)
  }))  
}