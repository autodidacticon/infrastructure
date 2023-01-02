data "aws_ec2_managed_prefix_list" "cloudfront-prefix-list" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}

resource "aws_security_group" "alb-security-group" {
  name = "alb-cloudfront"
  vpc_id = var.vpc_id

  # rule allowing traffic from cloudfront ip addresses
  # https://docs.aws.amazon.com/vpc/latest/userguide/working-with-aws-managed-prefix-lists.html
  ingress {
    from_port = 443
    protocol  = "tcp"
    to_port   = 443
    prefix_list_ids = [data.aws_ec2_managed_prefix_list.cloudfront-prefix-list.id]
  }

  # rule allowing traffic from this group
  ingress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    self = true
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_lb" "load-balancer" {
  name               = "kip"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-security-group.id]
  subnets            = var.public-subnet-ids

  enable_deletion_protection = true
}