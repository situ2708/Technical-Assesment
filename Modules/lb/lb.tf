resource "azurerm_public_ip" "web_lbpip" {
  name                = "${var.lb_name}-lbpublicip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku = "Standard"
  tags = var.tags
}

resource "azurerm_lb" "web_lb" {
  name                = "${var.lb_name}-web-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku = "Standard"
  frontend_ip_configuration {
    name                 = "web-lb-pip"
    public_ip_address_id = azurerm_public_ip.web_lbpip.id
  }
}

resource "azurerm_lb_backend_address_pool" "web_lb_backend_address_pool" {
  name                = "web-backend"
  loadbalancer_id     = azurerm_lb.web_lb.id
}

resource "azurerm_lb_probe" "web_lb_probe" {
  name                = "tcp-probe"
  protocol            = "Tcp"
  port                = 80
  loadbalancer_id     = azurerm_lb.web_lb.id
}

resource "azurerm_lb_rule" "web_lb_rule_app1" {
  name                           = "web-app1-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids        = azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id
  probe_id                       = azurerm_lb_probe.web_lb_probe.id
  loadbalancer_id                = azurerm_lb.web_lb.id
}

resource "azurerm_network_interface_backend_address_pool_association" "web_nic_lb_associate" {
  network_interface_id    = var.backend_vm_nic
  ip_configuration_name   = var.backend_vm_ip_config
  backend_address_pool_id = azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id
}
