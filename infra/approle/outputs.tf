output "concourse_role_id" {
  value = vault_approle_auth_backend_role.example_role.id
  sensitive = true
}
