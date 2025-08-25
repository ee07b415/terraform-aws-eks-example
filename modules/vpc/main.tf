module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = var.vpc_name
  # cidr = var.vpc_cidr

  azs = var.availability_zones
  # subnets should under the cidr range, this current setting require the cidr should be 10.0.0.0/16
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_dns_hostnames = true
}
