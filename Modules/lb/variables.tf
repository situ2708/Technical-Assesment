variable "lb_name" {
  type = string
  description = "External LB Name"
}

variable "location" {
  description = "Default region for deployed resources"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The resource group name to be imported"
  type        = string
  default     = null
}

variable "backend_vm_nic" {
  description = "nic of Web VM"
  type = string
  default = null
}

variable "backend_vm_ip_config" {
  description = "IP configuration name of web vm"
  type = string
  default = null
}

variable "tags" {
  type = map(string)
}
