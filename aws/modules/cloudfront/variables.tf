variable "domain-aliases" {
  type = list(string)
  description = "list of URI hostnames to alias the distribution to, eg. api.my-app.com, frontend.my-app.com"
}

variable "alb-domain-name" {
  description = "domain name of the alb"
}

variable "domain-cert-arn" {
  description = "arn of ACM certificate associated with the domain names passed as aliases, " +
  "certificate must be provisioned in us-east-1"
}

variable "application-name" {
  description = "name of the cloudfront distribution"
}
