variable "location"{
  description = "Location of AKS"
  type        = string
  default     = "eastus"
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

variable "environment" {
  description = "(Required) Environment of the cluster"
  type        = string
  default     = "dev"
}

variable "vnet_id" {
  description = "The ID of the Virtual Network that should be linked to the DNS Zone"
  type        = string
}

variable "postgresql_admin" {
  description = "The Administrator Login for the PostgreSQL Server."
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "Specifies the SKU Name for this PostgreSQL Server"
  type        = string
  default     = "GP_Gen5_2"
}

variable "postgresql_version" {
  description = "Specify the version of PostgreSQL to use"
  type        = string
}

variable "storage_mb" {
  description = "Max storage allowed for a server"
  type        = string
}

variable "backup_retention" {
  description = ""
  type        = string
  default     = "7"
}

variable "public_access_enabled" {
  description = "Whether or not public network access is allowed for this server"
  type        = bool
}

variable "ssl_enforce" {
  description = "Specify if SSL should be enforced on connections."
  type        = bool
}

variable "ssl_version" {
  description = "The minimum TLS version to support on the sever"
  type        = string
}

variable "tags" {
  description = "Any tags that should be present on the resources"
  type        = map(string)
  default     = {}
}

variable "app_subnet_id" {
  description = "The ID of the Apps subnet that the PostgreSQL server can be connected from"
  type        = string
}
