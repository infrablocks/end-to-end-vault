resource "aws_kms_key" "vault_unseal_key" {
  description             = "Vault unseal key"
  deletion_window_in_days = 10
}
