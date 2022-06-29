resource "vault_auth_backend" "example" {
  type = "approle"
}

resource "vault_approle_auth_backend_role" "example_role" {
  backend         = vault_auth_backend.example.path
  role_name       = var.role_name
  token_policies  = ["default", var.role_name]
  token_ttl = var.token_ttl
  token_max_ttl =  var.token_max_ttl
  token_period = var.token_period
  secret_id_ttl= var.secret_id_ttl
}

resource "vault_approle_auth_backend_role_secret_id" "id" {
  backend   = vault_auth_backend.example.path
  role_name = vault_approle_auth_backend_role.example_role.role_name
}

resource "vault_approle_auth_backend_login" "login" {
  backend   = vault_auth_backend.example.path
  role_id   = vault_approle_auth_backend_role.example_role.role_id
  secret_id = vault_approle_auth_backend_role_secret_id.id.secret_id
}

