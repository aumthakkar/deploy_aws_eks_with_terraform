
# === root/variables.tf === 

variable "access_ips" {}
variable "vpc_cidr" {}
variable "region" {}


variable "org_name" {
  default = "mts"
}

variable "env_name" {
  default = "dev"
}

# variable "pvt_key" {
#   ephemeral = true
# }



