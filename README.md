# EKS Terraform Repository

This repository contains Terraform configurations to provision an Amazon EKS cluster on AWS.

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform installed (version 1.0 or later)
- Pre-configured service account with enough access right, please be noted that there is no predefined policy for eks management, for minimum role access rule, please
  follow the message shown when apply the terraform to add the necessary roles.
   AmazonEC2FullAccess
   AmazonEKSClusterPolicy
   AmazonEKSServicePolicy
   AmazonS3FullAccess
   IAMFullAccess


## Usage

1. Initialize the Terraform working directory:
   ```
   terraform init
   ```

2. Review the planned changes:
   ```
   terraform plan
   ```

3. Apply the Terraform configuration:
   ```
   terraform apply
   ```

4. To destroy the resources when no longer needed:
   ```
   terraform destroy
   ```

The the terraform applied, the output will show the newly created k8s cluster's config, use 
```
aws eks update-kubeconfig --region your-region --name example-cluste
```
to add the eks context 