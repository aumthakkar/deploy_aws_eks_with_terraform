
# === networking/outputs.tf === 

output "vpc_id" {
  value = aws_vpc.my_eks_vpc.id
}

/*
output "public_subnets" {
  value = aws_subnet.pht_public_subnets[*].id
}
*/

output "private_subnets" {
  value = aws_subnet.pht_private_subnets[*].id
}

output "vpc_cidr" {
  value = aws_vpc.my_eks_vpc.cidr_block
}

/*
output "private_subnets" {
  value = aws_subnet.pht_private_subnets[*].id
}
*/

output "public_sg_ids" {
  value = [aws_security_group.cluster_sg["public_sg"].id]
}

output "efs_sg_ids" {
  value = [aws_security_group.cluster_sg["efs_sg"].id]
}

output "my_igw" {
  value = aws_internet_gateway.my_igw.id
}