resource "aws_alb_target_group" "target-group" {
  name = var.application-name
  port = var.application-port
  protocol = var.application-protocol
  vpc_id = var.vpc_id
  target_type = "ip"
  health_check {
    matcher = var.health-check-matcher
    path = var.health-check-path
  }
}

resource "aws_lb_listener" "kip-listener" {
  load_balancer_arn = var.load-balancer-arn
  port              = var.load-balancer-port
  protocol          = var.load-balancer-protocol
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate-arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target-group.arn
  }
}

variable "application-paths" {
  type = list(string)
  description = "list of URI paths that the application will bind to"
  default = ["/*"]
}


variable "application-host-headers" {
  description = "list of URI hostnames that identify the application"
  default = [var.application-domain-name]
}

resource "aws_lb_listener_rule" "listener-rule" {
  listener_arn = aws_lb_listener.kip-listener.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target-group.arn
  }

  condition {
    path_pattern {
      values = var.application-paths
    }
  }

  condition {
    host_header {
      values = var.application-host-headers
    }
  }
}
