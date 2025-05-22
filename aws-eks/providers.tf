
# === root/providers.tf ===

provider "aws" {
  region = var.region
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks_cluster.cluster_id
}

provider "kubernetes" {
  host                   = module.eks_cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_cluster.cluster_cert_auth_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

