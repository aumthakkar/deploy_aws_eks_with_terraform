
# === eks/outputs.tf ==== 

output "cluster_id" {
  value = aws_eks_cluster.my_eks_cluster.id
}

output "cluster_endpoint" {
  value = aws_eks_cluster.my_eks_cluster.endpoint
}

output "cluster_arn" {
  value = aws_eks_cluster.my_eks_cluster.arn
}

output "cluster_cert_auth_data" {
  value = aws_eks_cluster.my_eks_cluster.certificate_authority[0].data
}

output "cluster_version" {
  value = aws_eks_cluster.my_eks_cluster.version
}

output "cluster_security_group_id" {
  value = [aws_eks_cluster.my_eks_cluster.vpc_config[0].security_group_ids]
}

output "cluster_iam_role_name" {
  value = aws_iam_role.eks_master_role.name
}

output "cluster_iam_role_arn" {
  value = aws_iam_role.eks_master_role.arn
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = aws_eks_cluster.my_eks_cluster.identity[0].oidc[0].issuer
}

output "cluster_primary_security_group_id" {
  description = "The cluster primary security group ID created by the EKS cluster on 1.14 or later. Referred to as 'Cluster security group' in the EKS console."
  value       = aws_eks_cluster.my_eks_cluster.vpc_config[0].cluster_security_group_id
}

/*

# EKS Node Group Outputs - Public
output "node_group_public_id" {
  description = "Public Node Group ID"
  value       = aws_eks_node_group.my_eks_public_nodegroup.id
}

output "node_group_public_arn" {
  description = "Public Node Group ARN"
  value       = aws_eks_node_group.my_eks_public_nodegroup.arn
}

output "node_group_public_status" {
  description = "Public Node Group status"
  value       = aws_eks_node_group.my_eks_public_nodegroup.status
}

output "node_group_public_version" {
  description = "Public Node Group Kubernetes Version"
  value       = aws_eks_node_group.my_eks_public_nodegroup.version
}

*/

# EKS Node Group Outputs - Private
output "node_group_private_id" {
  description = "Private Node Group ID"
  value       = aws_eks_node_group.my_eks_private_nodegroup.id
}

output "node_group_private_arn" {
  description = "Private Node Group ARN"
  value       = aws_eks_node_group.my_eks_private_nodegroup.arn
}

output "node_group_private_status" {
  description = "Private Node Group status"
  value       = aws_eks_node_group.my_eks_private_nodegroup.status
}

output "node_group_private_version" {
  description = "Private Node Group Kubernetes Version"
  value       = aws_eks_node_group.my_eks_private_nodegroup.version
}


# EKS IRSA related Outputs

output "aws_iam_openid_connect_provider_arn" {
  value = aws_iam_openid_connect_provider.oidc_provider.arn
}

# Extract OIDC Provider from OIDC Provider ARN

locals {
  aws_iam_openid_connect_provider_extract = element(split("oidc-provider/", "${aws_iam_openid_connect_provider.oidc_provider.arn}"), 1)
}

output "aws_iam_openid_connect_provider_extract_from_arn" {
  value = local.aws_iam_openid_connect_provider_extract
}

# Sample Outputs for Reference
/*
aws_iam_openid_connect_provider_arn = "arn:aws:iam::180789647333:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/A9DED4A4FA341C2A5D985A260650F232"
aws_iam_openid_connect_provider_extract_from_arn = "oidc.eks.us-east-1.amazonaws.com/id/A9DED4A4FA341C2A5D985A260650F232"
*/


# # EKS-EBS-CSI-Addon related Outputs

# output "ebs_eks_addon_arn" {
#   value = aws_eks_addon.aws_ebs_csi_driver.arn
# }

# output "ebs_eks_addon_id" {
#   value = aws_eks_addon.aws_ebs_csi_driver.id
# }