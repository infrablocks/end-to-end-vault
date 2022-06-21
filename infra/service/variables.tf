variable "region" {}
variable "component" {}
variable "deployment_identifier" {}

variable "domain_name" {}

variable "service_desired_count" {}

variable "secrets_bucket_name" {}

variable "vault_image" {}
variable "vault_service_container_port" {}
variable "vault_service_host_port" {}
variable "vault_allow_cidrs" {
  type = list(string)
}

variable "domain_state_bucket_name" {}
variable "domain_state_key" {}
variable "domain_state_bucket_region" {}
variable "domain_state_bucket_is_encrypted" {}

variable "network_state_bucket_name" {}
variable "network_state_key" {}
variable "network_state_bucket_region" {}
variable "network_state_bucket_is_encrypted" {}

variable "cluster_state_bucket_name" {}
variable "cluster_state_key" {}
variable "cluster_state_bucket_region" {}
variable "cluster_state_bucket_is_encrypted" {}
