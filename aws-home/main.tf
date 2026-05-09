terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.47.0"
    }
  }
}

provider "aws" {
  alias  = "us-east-2"
  region = "us-east-2"
  default_tags {
    tags = {
      environment = "home"
    }
  }
}

# You cannot create a new backend by simply defining this and then
# immediately proceeding to "terraform apply". The S3 backend must
# be bootstrapped according to the simple yet essential procedure in
# https://github.com/cloudposse/terraform-aws-tfstate-backend#usage
module "terraform_state_backend" {
  source = "cloudposse/tfstate-backend/aws"
  # Cloud Posse recommends pinning every module to a specific version
  version    = "0.38.1"
  namespace  = "home"
  stage      = "test"
  name       = "terraform"
  attributes = ["state"]

  terraform_backend_config_file_path = "."
  terraform_backend_config_file_name = "backend.tf"
  force_destroy                      = false
}

module "iam" {
    source = "../aws/modules/iam"
}

#module "vpc" {
#  source = "terraform-aws-modules/vpc/aws"
#
#  name = "home"
#  cidr = "10.0.0.0/16"
#
#  azs                          = ["us-east-2a", "us-east-2b", "us-east-2c"]
#  private_subnets              = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
#  public_subnets               = ["10.0.100.0/24", "10.0.101.0/24", "10.0.102.0/24"]
#  database_subnets             = ["10.0.200.0/24", "10.0.201.0/24", "10.0.202.0/24"]
#  create_database_subnet_group = false
#  enable_nat_gateway           = false
#  single_nat_gateway           = true
#  enable_vpn_gateway           = false
#}

#module "eks" {
#  source               = "../aws/modules/eks"
#  intra-subnet-ids   = module.vpc.intra_subnets
#  private-subnet-ids = module.vpc.private_subnets
#  vpc-cidr           = module.vpc.vpc_cidr_block
#  vpc_id             = module.vpc.vpc_id
#}
