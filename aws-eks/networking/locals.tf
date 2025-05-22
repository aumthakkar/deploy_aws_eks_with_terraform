
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