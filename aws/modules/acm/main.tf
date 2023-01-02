resource "aws_acm_certificate" "certificate" {
  domain_name       = var.domain-name
  subject_alternative_names = ["*.${var.domain-name}"]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

output "certificate-arn" {
  value = aws_acm_certificate.certificate.arn
}