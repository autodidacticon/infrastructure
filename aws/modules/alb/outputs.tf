output "id" {
  value = aws_security_group.alb-security-group.id
}

output "alb-security-group-id" {
  value = aws_security_group.alb-security-group.id
}

output "dns-name" {
  value = aws_lb.load-balancer.dns_name
}

output "zone-id" {
  value = aws_lb.load-balancer.zone_id
}