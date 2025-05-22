
# === eks/variables.tf ====

# EKS Cluster Input Variables

variable "cluster_name" {}

variable "eks_cluster_version" {
  description = "Kubernetes minor version to use for the EKS cluster (for example 1.21)"
}

variable "cluster_service_ipv4_cidr" {
  description = "service ipv4 cidr for the kubernetes cluster"
  type        = string
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. When it's set to `false` ensure to have a proper private access with `cluster_endpoint_private_access = true`."
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint."
  type        = list(string)
}

variable "pht_public_subnets" {}

variable "pht_private_subnets" {}

# EKS Public Node Group Variables

variable "eks_public_nodegroup_name" {}
variable "public_nodegroup_desired_size" {}
variable "public_nodegroup_max_size" {}
variable "public_nodegroup_min_size" {}
variable "public_nodegroup_max_unavail_pctage" {}

variable "public_nodegroup_ami_type" {}
variable "public_nodegroup_capacity_type" {}
variable "public_nodegroup_disk_size" {}
variable "public_nodegroup_instance_types" {}
variable "public_nodegroup_key_name" {}


# EKS Private Node Group variables

variable "eks_private_nodegroup_name" {}
variable "private_nodegroup_desired_size" {}
variable "private_nodegroup_max_size" {}
variable "private_nodegroup_min_size" {}
variable "private_nodegroup_max_unavail_pctage" {}

variable "private_nodegroup_ami_type" {}
variable "private_nodegroup_capacity_type" {}
variable "private_nodegroup_disk_size" {}
variable "private_nodegroup_instance_types" {}
variable "private_nodegroup_key_name" {}


