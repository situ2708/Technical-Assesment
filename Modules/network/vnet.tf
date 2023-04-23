resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  address_prefixes     = [each.value.range]
  virtual_network_name = azurerm_virtual_network.vnet.name
  service_endpoints    = each.value.service_endpoints
}

resource "azurerm_network_security_group" "nsg_groups" {
  for_each            = toset(var.network_security_groups)
  name                = "${each.value}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "sg_association" {
  depends_on          = [azurerm_network_security_group.nsg_groups]
  for_each            = var.subnets
  network_security_group_id = azurerm_network_security_group.nsg_groups[each.value.nsg].id
  subnet_id                 = azurerm_subnet.subnet[each.key].id
}

resource "azurerm_network_security_rule" "web-svc-rules" {
  for_each                    = var.nsg_rules_web
  name                        = each.key
  direction                   = each.value.direction
  access                      = each.value.access
  priority                    = each.value.priority
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg_groups[0].name
}

resource "azurerm_network_security_rule" "app-svc-rules" {
  for_each                    = var.nsg_rules_app 
  name                        = each.key
  direction                   = each.value.direction
  access                      = each.value.access
  priority                    = each.value.priority
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg_groups[1].name
}

resource "azurerm_network_security_rule" "db-svc-rules" {
  for_each                    = var.nsg_rules_db
  name                        = each.key
  direction                   = each.value.direction
  access                      = each.value.access
  priority                    = each.value.priority
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg_groups[2].name
}
