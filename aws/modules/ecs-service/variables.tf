variable "service-name" {
}
variable "image" {
}
variable "port" {
}
variable "ecs-cluster-id" {
}
variable "target-group-arn" {
}

variable "region" {}

variable "execution-role-arn" {}

variable "subnet-ids" {}

variable "environment" {
  type = list(
    object({
      name = string
      value = string
    })
  )
  default = []
}

variable "security-groups" {
  type = list(string)
  default = []
}