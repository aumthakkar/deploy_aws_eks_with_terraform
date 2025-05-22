## ===== lb-controller/backend.tf ====##

terraform {
  backend "s3" {
    region = "eu-north-1"

    key    = "aws-lbc/terraform.tfstate"
    bucket = "pht-dev-eks-cluster-state"

    use_lockfile = true
  }
}