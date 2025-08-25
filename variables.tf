variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

# variable "cluster_name" {
#   description = "Name of the EKS cluster"
#   type        = string
# }

# variable "vpc_id" {
#   description = "VPC ID where the EKS cluster will be created"
#   type        = string
# }

# variable "subnet_ids" {
#   description = "List of subnet IDs for the EKS cluster"
#   type        = list(string)
# }

# variable "instance_types" {
#   description = "List of EC2 instance types for the EKS node group"
#   type        = list(string)
#   default     = ["t3.medium"]
# }

# variable "desired_size" {
#   description = "Desired number of worker nodes"
#   type        = number
#   default     = 1
# }

# variable "max_size" {
#   description = "Maximum number of worker nodes"
#   type        = number
#   default     = 1
# }

# variable "min_size" {
#   description = "Minimum number of worker nodes"
#   type        = number
#   default     = 1
# }