# Terraform AWS Provider Block
provider "aws" {
    region = "us-east-1"  
}

# Retriving EKS Cluster Name using Terraform Remote State Data Source from 1-aws-eks-cluster-basics/5.2-aws-eks-outputs.tf
data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

# Terraform Kubernetes Provider Block
provider "kubernetes" {
    host = data.terraform_remote_state.eks.outputs.cluster_endpoint
    cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
    token = data.aws_eks_cluster_auth.cluster.token
}