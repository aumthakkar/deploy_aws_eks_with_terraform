data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    region = var.aws_region

    key    = "eks-cluster/terraform.tfstate"
    bucket = "pht-dev-eks-cluster-state"
  }
}