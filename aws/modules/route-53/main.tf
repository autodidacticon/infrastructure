variable "domain-name" {
  default = ""
}
resource "aws_route53_zone" "zone" {
  name = var.domain-name
}

resource "aws_route53_record" "root" {
  name = var.domain-name
  type = "A"
  zone_id = aws_route53_zone.zone.zone_id

  alias {
    evaluate_target_health = true
    name                   = var.cloudfront-dns-name
    zone_id                = var.zone-id
  }
}
