variable "vpc_id" {
  description = "id of the vpc to deploy the application load balancer"
}

variable "public-subnet-ids" {
  description = "list of ids corresponding to public subnets in the given vpc"
}

variable "certificate-arn" {
  description = "arn of the ACM certificate associated with the domain"
}