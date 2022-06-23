module "bastion" {
  source  = "infrablocks/bastion/aws"
  version = "2.1.0-rc.8"

  vpc_id     = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.network.outputs.public_subnet_ids

  component             = var.component
  deployment_identifier = var.deployment_identifier

  ami = ""

  ssh_public_key_path = var.bastion_ssh_public_key_path

  allowed_cidrs = var.bastion_allow_cidrs
  egress_cidrs  = var.bastion_egress_cidrs
  associate_public_ip_address = var.bastion_associate_public_ip_address
}
