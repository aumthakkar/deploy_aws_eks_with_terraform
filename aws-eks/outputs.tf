output "cluster_id" {
  description = "The name/id of the EKS Cluster"
  value       = module.eks_cluster.cluster_id
}

output "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = module.eks_cluster.cluster_endpoint
}

output "cluster_arn" {
  description = "The ARN of the EKS Cluster"
  value       = module.eks_cluster.cluster_arn
}

output "cluster_cert_auth_data" {
  description = "Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster"
  value       = module.eks_cluster.cluster_cert_auth_data
}

output "cluster_version" {
  description = "The Kubernetes server version for the EKS cluster."
  value       = module.eks_cluster.cluster_version
}

output "cluster_security_group_id" {
  value = module.eks_cluster.cluster_security_group_id
}

output "cluster_iam_role_name" {
  description = "IAM role name of the EKS cluster."
  value       = module.eks_cluster.cluster_iam_role_name
}

output "cluster_iam_role_arn" {
  description = "IAM role ARN of the EKS cluster."
  value       = module.eks_cluster.cluster_iam_role_arn
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = module.eks_cluster.cluster_oidc_issuer_url
}

output "cluster_primary_security_group_id" {
  description = "The cluster primary security group ID created by the EKS cluster on 1.14 or later. Referred to as 'Cluster security group' in the EKS console."
  value       = module.eks_cluster.cluster_primary_security_group_id
}

/* 

# EKS Node Group Outputs - Public
output "node_group_public_id" {
  description = "Public Node Group ID"
  value       = module.eks_cluster.node_group_public_id
}

output "node_group_public_arn" {
  description = "Public Node Group ARN"
  value       = module.eks_cluster.node_group_public_arn
}

output "node_group_public_status" {
  description = "Public Node Group status"
  value       = module.eks_cluster.node_group_public_status
}

output "node_group_public_version" {
  description = "Public Node Group Kubernetes Version"
  value       = module.eks_cluster.node_group_public_version
}

output "public_subnets" {
  value = module.networking.public_subnets
}

*/

# EKS Node Group Outputs - Private
output "node_group_private_id" {
  description = "Private Node Group ID"
  value       = module.eks_cluster.node_group_private_id
}

output "node_group_private_arn" {
  description = "Private Node Group ARN"
  value       = module.eks_cluster.node_group_private_arn
}

output "node_group_private_status" {
  description = "Private Node Group status"
  value       = module.eks_cluster.node_group_private_status
}

output "node_group_private_version" {
  description = "Private Node Group Kubernetes Version"
  value       = module.eks_cluster.node_group_private_version
}

output "private_subnets" {
  value = module.networking.private_subnets
}


# EKS IRSA related Outputs

output "aws_iam_openid_connect_provider_arn" {
  value = module.eks_cluster.aws_iam_openid_connect_provider_arn
}

# Extract OIDC Provider from OIDC Provider ARN

output "aws_iam_openid_connect_provider_extract_from_arn" {
  value = module.eks_cluster.aws_iam_openid_connect_provider_extract_from_arn
}

# VPC Outputs

output "vpc_cidr" {
  value = module.networking.vpc_cidr
}

output "vpc_id" {
  value = module.networking.vpc_id
}

output "efs_sg_ids" {
  value = module.networking.efs_sg_ids
}




