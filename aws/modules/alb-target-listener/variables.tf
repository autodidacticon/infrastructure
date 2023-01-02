variable "vpc_id" {
  description = "id of the vpc to deploy the application load balancer"
}

variable "application-domain-name" {
  description = "domain name used by the application"
}

variable "application-name" {
  description = "name of the application, used by target group and listener rule"
}

variable "application-port" {
  description = "port used by the application"
  default = "8080"
}

variable "application-protocol" {
  description = "protocol used by the application"
  default = "HTTPS"
}

variable "health-check-matcher" {
  description = "response codes to use when checking for a healthy response from target"
  default = "200"
}

variable "health-check-path" {
  description = "destination for the health check request"
  default = "/"
}

variable "load-balancer-arn" {
  description = "ARN of the load balancer to bind to"
}

variable "load-balancer-port" {
  description = "port to bind to"
  default = "443"
}

variable "load-balancer-protocol" {
  description = "protocol to use for requests"
  default = "HTTPS"
}

variable "certificate-arn" {
  description = "ACM certificate arn used for SSL termination"
}
