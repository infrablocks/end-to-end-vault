locals {
  env_file_object_key = "vault/service/environments/default.env"
  configuration_file_object_key = "vault/service/configuration/config.hcl"

  vault_dns_name = "${var.component}-${var.deployment_identifier}.${data.terraform_remote_state.domain.outputs.domain_name}"
  env_file_object_path = "s3://${var.secrets_bucket_name}/${local.env_file_object_key}"
  configuration_file_object_path = "s3://${var.secrets_bucket_name}/${local.configuration_file_object_key}"
  env_file_contents = templatefile("${path.root}/envfiles/vault.env.tftpl", {
    vault_dns_name = local.vault_dns_name
    vault_configuration_file_object_path = local.configuration_file_object_path
  })
  configuration_file_contents = templatefile("${path.root}/configuration/vault.hcl.tftpl", {
    kms_key = aws_kms_key.vault_unseal_key.id
  })
}

resource "aws_s3_object" "env" {
  key = local.env_file_object_key
  bucket = var.secrets_bucket_name
  content = local.env_file_contents

  server_side_encryption = "AES256"
}

resource "aws_s3_object" "configuration" {
  key = local.configuration_file_object_key
  bucket = var.secrets_bucket_name
  content = local.configuration_file_contents

  server_side_encryption = "AES256"
}
