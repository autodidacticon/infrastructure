
output "oidc_url" {
  description = "The OIDC URL. Useful in IAM assume role policies."
  value       = local.circleci_oidc_url
}
