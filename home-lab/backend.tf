terraform {
  required_version = ">= 0.12.2"

  backend "s3" {
    region         = "us-east-2"
    bucket         = "home-test-terraform-state"
    key            = "terraform.tfstate"
    dynamodb_table = "home-test-terraform-state-lock"
    profile        = ""
    role_arn       = ""
    encrypt        = "true"
  }
}
