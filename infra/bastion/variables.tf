variable "region" {}
variable "component" {}
variable "deployment_identifier" {}

variable "secrets_bucket_name" {}

variable "bastion_ssh_public_key_path" {}
variable "bastion_allow_cidrs" {
  type = list(string)
}
variable "bastion_egress_cidrs" {
  type = list(string)
}
variable "bastion_associate_public_ip_address" {}

variable "network_state_bucket_name" {}
variable "network_state_key" {}
variable "network_state_bucket_region" {}
variable "network_state_bucket_is_encrypted" {}
