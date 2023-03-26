variable "circleci_organization_id" {
  description = "The UUID formatted Organization ID from CircleCI. This can be retrieved from Organization Settings in CircleCI."
  type        = string
  default = "3d92d4b3-3c85-4bcf-937e-8018043ec98a"
}

variable "thumbprints" {
  type        = list(string)
  description = "The OIDC thumbprints used for the OIDC provider. You should probably use the default."
  default     = ["9E:99:A4:8A:99:60:B1:49:26:BB:7F:3B:02:E2:2D:A2:B0:AB:72:80"]
}

variable "tags" {
  type        = map(string)
  description = <<-EOT
  Tags to attach to created resources. Tags here will override default tags in the event of a conflict.
  EOT
  default     = {}
}
