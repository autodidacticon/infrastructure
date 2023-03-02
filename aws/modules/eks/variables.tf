variable "region" {
  default = "us-east-2"
}

variable "cluster-name" {
  default = "test"
}

variable "tags" {
  type = map(string)
  default = {
    eks-cluster-name = "test"
  }
}

variable "intra-subnet-ids" {
}

variable "private-subnet-ids" {
}

variable "vpc_id" {
}

variable "vpc-cidr" {
}
