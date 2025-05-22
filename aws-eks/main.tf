
# === root/main.tf ===

module "networking" {
  source = "./networking"

  vpc_cidr = var.vpc_cidr

  pub_sub_count = 2
  pub_sub_cidr  = [for i in range(2, 255, 2) : cidrsubnet(var.vpc_cidr, 8, i)]

  prv_sub_count = 2
  prv_sub_cidr  = [for i in range(1, 255, 2) : cidrsubnet(var.vpc_cidr, 8, i)]

  security_groups = local.security_groups

}

module "compute" {
  source = "./compute"
  vpc_id = module.networking.vpc_id

  instance_type = "t3.micro"

  key_name        = "mtckey"
  public_key_path = "${path.root}/mtckey.pub"

  pub_subnet            = module.networking.public_subnets[0]
  bastion_public_sg_ids = module.networking.bastion_public_sg_ids

}


module "eks_cluster" {
  source = "./eks"

  cluster_name        = "${local.name}-eksdemo"
  eks_cluster_version = "1.32"

  cluster_service_ipv4_cidr            = "172.20.0.0/16"
  cluster_endpoint_private_access      = false
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  pht_public_subnets = module.networking.public_subnets
  pht_private_subnets = module.networking.private_subnets

  eks_public_nodegroup_name           = "${local.name}-public-nodegroup"
  public_nodegroup_desired_size       = 2
  public_nodegroup_max_size           = 3
  public_nodegroup_min_size           = 2
  public_nodegroup_max_unavail_pctage = 50

  public_nodegroup_ami_type       = "AL2_x86_64"
  public_nodegroup_capacity_type  = "SPOT"
  public_nodegroup_disk_size      = 20
  public_nodegroup_instance_types = ["t3.large"]
  public_nodegroup_key_name       = "mtckey"

  
  eks_private_nodegroup_name           = "${local.name}-private-nodegroup"
  private_nodegroup_desired_size       = 1
  private_nodegroup_max_size           = 2
  private_nodegroup_min_size           = 1
  private_nodegroup_max_unavail_pctage = 50

  private_nodegroup_ami_type       = "AL2_x86_64"
  private_nodegroup_capacity_type  = "SPOT"
  private_nodegroup_disk_size      = 20
  private_nodegroup_instance_types = ["t3.large"]
  private_nodegroup_key_name       = "mtckey"

}



