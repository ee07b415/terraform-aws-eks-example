terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.2"

  backend "s3" {
    bucket         = "terra-eks-example"
    key            = "dev/terraform.tfstate"  # Organize by environment/project
    region         = "us-west-1"
    encrypt        = true
  }
}