output "tls_private_key" {
  value     = tls_private_key.vm_ssh.private_key_pem
  sensitive = true
}
