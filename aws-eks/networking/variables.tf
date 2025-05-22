
# === networking/variables.tf ====

variable "vpc_cidr" {}

variable "pub_sub_count" {}
variable "pub_sub_cidr" {}


variable "prv_sub_count" {}
variable "prv_sub_cidr" {}


variable "security_groups" {}

variable "org_name" {
  default = "mts"
}

variable "env_name" {
  default = "dev"
}

