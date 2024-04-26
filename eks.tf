provider "aws" {
  region = "us-east-1" # Adjust the region to your preference
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 20.0"
  cluster_name    = "argocd-eks"
  cluster_version = "1.29"
  subnet_ids      = ["subnet-f3be15b9", "subnet-1eec0b42", "subnet-1eec0b42"]
  vpc_id          = "vpc-a083cfdb"
  cluster_endpoint_public_access  = true
  eks_managed_node_groups = {
    example = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
    }
  }
  enable_cluster_creator_admin_permissions = true
}


output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}


#output "kubeconfig" {
#  value = module.eks.config_output_path
#}
