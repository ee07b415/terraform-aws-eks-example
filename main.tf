module "eks" {
  source         = "./modules/eks/"
  cluster_name   = "example-cluster"
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnets
  instance_types = ["t3.micro"]  # Smallest viable option for EKS
  desired_size   = 1
  max_size       = 1
  min_size       = 1
}

module "vpc" {
  source = "./modules/vpc"
  vpc_name = "my-custom-vpc"
  # vpc_cidr = "10.0.0.0/16"
  availability_zones = ["us-west-2a", "us-west-2b"] 
}

# provider definition is provider wise default
provider "aws" {
  region = var.region
}

# data is the resource query from your cloud provider, this ami will for standalone ec2
# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
#   }

#   owners = ["099720109477"] # Canonical
# }

# resource is the data componenet manual defined, this for standalone ec2
# resource "aws_instance" "app_server" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t2.micro"

#   vpc_security_group_ids = [module.vpc.default_security_group_id]
#   subnet_id              = module.vpc.private_subnets[0]

#   tags = {
#     Name = "learn-terraform"
#   }
# }