module "wildcard_certificate" {
  source  = "infrablocks/acm-certificate/aws"
  version = "1.1.0"

  domain_name = "*.${var.domain_name}"

  zone_id = data.terraform_remote_state.domain.outputs.public_zone_id
}