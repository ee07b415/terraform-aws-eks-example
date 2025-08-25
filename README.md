# EKS Terraform Infrastructure

A simple Terraform configuration for deploying Amazon EKS clusters with multi-node group support.

## 🏗️ Project Structure

```
project-root/
├── modules/
│   ├── eks/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── vpc/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
└── README.md
```

## 📚 Terraform Concepts Explained

### **Provider**
Defines which cloud platform Terraform should use. Acts as a plugin for specific services.
```hcl
provider "aws" {
  region = "us-east-1"
}
```

### **Resource**
The actual infrastructure components you want to create (EC2, VPC, EKS cluster, etc).
```hcl
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn
}
```

### **Data**
Queries existing resources or information from your cloud provider (like existing AMIs, VPCs).
```hcl
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
}
```

### **Module**
Reusable groups of resources. Like functions in programming - define once, use many times.
```hcl
module "eks" {
  source       = "./modules/eks/"
  cluster_name = "my-cluster"
}
```

### **Output**
Values you want to export after Terraform creates resources (like cluster endpoint, node IPs).
```hcl
output "cluster_name" {
  value = aws_eks_cluster.this.name
}
```

### **Backend**
Where Terraform stores its state file (local file, S3, etc). Tracks what resources exist.
```hcl
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "eks/terraform.tfstate"
  }
}
```

## 🚀 Quick Start

### 1. Prerequisites
- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) v2 configured
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

### 2. AWS Permissions
Your AWS user needs these policies:
- `AmazonEKSClusterPolicy`
- `AmazonEC2FullAccess`
- `IAMFullAccess`
- `AmazonEKSServicePolicy`
- `AmazonS3FullAccess`

please be noted that there is no predefined policy for eks management, for minimum role access rule, please follow the message shown when apply the terraform to add the necessary roles.

### 3. Deploy

```bash
# Clone and navigate
git clone <your-repo>
cd eks-terraform-infrastructure

# Initialize Terraform
terraform init

# Review what will be created
terraform plan

# Deploy infrastructure
terraform apply
```

### 4. Configure kubectl

```bash
# Get the command from Terraform output
terraform output kubeconfig_command

# Or run directly:
aws eks update-kubeconfig --region us-east-1 --name example-cluster

# Test connection
kubectl get nodes
```

## 🎯 Node Group Types

### General Purpose Nodes
- **Use**: Web apps, APIs, general workloads
- **Instances**: t3.medium, t3.large
- **Label**: `node-type: general`

### High Memory Nodes
- **Use**: Databases, caching, memory-intensive apps
- **Instances**: r5.large, r5.xlarge
- **Label**: `node-type: high-memory`
- **Taint**: `workload-type=memory-intensive:NoSchedule`

### GPU Nodes
- **Use**: ML training, AI inference
- **Instances**: g4dn.xlarge, p3.2xlarge
- **Label**: `node-type: gpu`
- **Taint**: `nvidia.com/gpu=true:NoSchedule`

## 💰 Cost Settings

For learning/development:
```hcl
# In main.tf
general_instance_types = ["t3.micro"]
desired_size          = 1
max_size             = 1
enable_high_memory_nodes = false
enable_gpu_nodes        = false
```

Estimated cost: ~$79/month (EKS control plane + 1 t3.micro node)

## 🔧 Common Commands

```bash
# Deploy
terraform apply

# Update infrastructure
terraform plan
terraform apply

# Destroy (careful!)
terraform destroy

# Check outputs
terraform output

# Refresh state
terraform refresh
```

## ⚠️ Common Issues

**IAM Permission Error:**
```bash
aws iam attach-user-policy --user-name YOUR_USER --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy
```

**VPC Dependencies Error:**
```bash
# Destroy EKS first, then VPC
terraform destroy -target=module.eks
terraform destroy -target=module.vpc
```

**kubectl Access:**
```bash
# Update kubeconfig
aws eks update-kubeconfig --region REGION --name CLUSTER_NAME
```

## 🎮 Example Kubernetes Deployments

### General Workload
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-app
spec:
  containers:
  - name: nginx
    image: nginx
  nodeSelector:
    node-type: general
```

### GPU Workload
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: ml-job
spec:
  containers:
  - name: tensorflow
    image: tensorflow/tensorflow:latest-gpu
    resources:
      limits:
        nvidia.com/gpu: 1
  nodeSelector:
    node-type: gpu
  tolerations:
  - key: "nvidia.com/gpu"
    value: "true"
    effect: "NoSchedule"
```

## 📋 Key Files Explained

- **`main.tf`** - Main configuration, calls modules
- **`variables.tf`** - Input parameters for customization
- **`outputs.tf`** - Values exported after deployment
- **`providers.tf`** - AWS provider configuration
- **`modules/eks/`** - EKS cluster and node group definitions
- **`modules/vpc/`** - Network infrastructure (VPC, subnets)

## 🔄 Workflow

1. **Plan** - `terraform plan` (see what will change)
2. **Apply** - `terraform apply` (create/update resources)
3. **Configure** - Update kubeconfig for kubectl access
4. **Deploy** - Deploy applications to Kubernetes
5. **Destroy** - `terraform destroy` (clean up when done)

---

**Remember**: Always run `terraform destroy` when you're done learning to avoid ongoing charges!