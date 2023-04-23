variable "location"{
  description = "Location of AKS"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The resource group name to be imported"
  type        = string
  default     = null
}

variable "environment" {
  description = "Environmenr"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Any tags that should be present on the resources"
  type        = map(string)
  default     = {}
}

variable "vm_subnet_ids" {
  description = "The ID of the Subnet where this Network Interface should be located in"
  type        = list(string)
}

variable "private_ip_address_allocation" {
  description = "The allocation method used for the Private IP Address"
  type        = string
  default     = "Static"
}

variable "nsg_ids" {
  description = "The IDs of the Network Security Group which should be attached to the Network Interface"
  type        = list(string)
}

variable "nic_names" {
  description = "The IDs of the nic which should be attached to vm"
  type        = list(string)
}

variable "vm_config" {
  description = "VM Configurations"
  type        = map(object({
    vm_size           = string
    vm_admin_username = string
    os_disk_caching   = string
    os_disk_storage_type = string
    source_image_publisher = string
    source_image_offer = string
    source_image_sku = string
    source_image_version = string
  }))
}
