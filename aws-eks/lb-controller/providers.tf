provider "aws" {
  region = var.aws_region
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

provider "kubernetes" {
  host = data.terraform_remote_state.eks.outputs.cluster_endpoint

  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_cert_auth_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes = {
    host = data.terraform_remote_state.eks.outputs.cluster_endpoint

    cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_cert_auth_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

