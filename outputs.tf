# output "cluster_endpoint" {
#   description = "Endpoint for EKS control plane"
#   value       = module.eks.cluster_endpoint
# }

# output "cluster_security_group_id" {
#   description = "Security group ID attached to the EKS cluster"
#   value       = module.eks.cluster_security_group_id
# }

output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.cluster_name
}

# Output values allow you to access attributes from your Terraform configuration and consume their values with other automation tools or workflows.
# output "instance_hostname" {
#   description = "Private DNS name of the EC2 instance."
#   value       = aws_instance.app_server.private_dns
# }