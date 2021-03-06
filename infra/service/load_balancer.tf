data "aws_acm_certificate" "wildcard" {
  domain = "*.${var.domain_name}"
}

module "vault_load_balancer" {
  source = "infrablocks/ecs-load-balancer/aws"
  version = "3.1.0-rc.6"

  component = var.component
  deployment_identifier = var.deployment_identifier

  region = var.region
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.network.outputs.public_subnet_ids

  service_name = var.component
  service_port = var.vault_service_host_port

  service_certificate_arn = data.aws_acm_certificate.wildcard.arn

  domain_name = data.terraform_remote_state.domain.outputs.domain_name
  public_zone_id = data.terraform_remote_state.domain.outputs.public_zone_id
  private_zone_id = data.terraform_remote_state.domain.outputs.private_zone_id

  allow_cidrs = var.vault_allow_cidrs

  health_check_target = "HTTP:${var.vault_service_host_port}/v1/sys/health?sealedcode=200&uninitcode=200&standbycode=200"

  expose_to_public_internet = "yes"
  include_public_dns_record = "yes"
}
