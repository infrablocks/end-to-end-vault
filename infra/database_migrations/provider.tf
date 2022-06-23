provider "aws" {
  region = var.region
}

provider "sql" {
  alias = "postgres"
  url   = "postgres://${var.database_master_user}:${var.database_master_user_password}@localhost:${data.terraform_remote_state.database.outputs.postgres_database_port}/${var.database_name}"
}
