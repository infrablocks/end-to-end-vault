locals {
  env_file_object_key = "vault/service/environments/default.env"
  configuration_file_object_path = "vault/service/configuration/config.hcl.tpl"

  vault_dns_name = "${var.component}-${var.deployment_identifier}.${data.terraform_remote_state.domain.outputs.domain_name}"
  env_file_object_path = "s3://${var.secrets_bucket_name}/${local.env_file_object_key}"
  configuration_file_object_path = "s3://${var.secrets_bucket_name}/${local.configuration_file_object_path}"
  env_file_contents = templatefile("${path.root}/envfiles/vault.env.tpl", {
    vault_dns_name = local.vault_dns_name
    vault_configuration_file_object_path = local.configuration_file_object_path
  })
  configuration_file_contents = file("${path.root}/configuration/vault.hcl.tpl")
}

resource "aws_s3_bucket_object" "env" {
  key = local.env_file_object_key
  bucket = var.secrets_bucket_name
  content = local.env_file_contents

  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "configuration" {
  key = local.configuration_file_object_path
  bucket = var.secrets_bucket_name
  content = local.configuration_file_contents

  server_side_encryption = "AES256"
}
