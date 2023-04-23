resource "random_password" "postgres_password" {
  length           = 16
  special          = true
 }

resource "azurerm_postgresql_server" "postgres" {
  name                              = local.postgresql_name
  location                          = var.location
  resource_group_name               = var.resource_group_name
  administrator_login               = var.postgresql_admin
  administrator_login_password      = random_password.postgres_password.result
  sku_name                          = var.sku_name
  version                           = var.postgresql_version
  storage_mb                        = var.storage_mb
  backup_retention_days             = var.backup_retention
  public_network_access_enabled     = var.public_access_enabled
  ssl_enforcement_enabled           = var.ssl_enforce
  ssl_minimal_tls_version_enforced  = var.ssl_version
  threat_detection_policy {
    enabled = true
  }
  tags                              = var.tags
}

resource "azurerm_postgresql_virtual_network_rule" "postgres" {
  name                = "postgresql-vnet-rule"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.postgres.name
  subnet_id           = var.app_subnet_id
  depends_on          = [azurerm_postgresql_server.postgres]
}