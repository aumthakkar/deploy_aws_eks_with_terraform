
# === root/locals.tf ===

locals {

  name        = "${var.org_name}-${var.env_name}"
  owners      = var.org_name
  environment = var.env_name

}

locals {
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}

locals {
  security_groups = {
    public_sg = {
      name        = "public-sg"
      description = "public-security-group"
      tags = {
        Name = "${local.name}-public-sg"
      }
      ingress = {
        ssh = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = var.access_ips
        }
      }
    }

    efs_sg = {
      name        = "efs-sg"
      description = "vpc-access-to-efs"
      tags = {
        Name = "${local.name}-efs-sg"
      }
      ingress = {
        ssh = {
          from        = 2049
          to          = 2049
          protocol    = "tcp"
          cidr_blocks = var.vpc_cidr
        }
      }
    }
  }
}

