output "tls_private_key" {
  value     = module.vm.tls_private_key
  sensitive = true
}
