variable "service_state_bucket_name" {}
variable "service_state_key" {}
variable "service_state_bucket_region" {}
variable "service_state_bucket_is_encrypted" {}

variable "role_name" {}
variable "token_ttl" {
  type = number
  default = 86400
}
variable "token_max_ttl" {
  type = number
  default = 31104000
}
variable "token_period" {
  type = number
  default = 31104000
}
variable "secret_id_ttl" {
  type = number
  default = 31104000
}
