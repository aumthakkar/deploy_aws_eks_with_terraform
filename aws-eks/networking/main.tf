
# === networking/main.tf ===

resource "random_integer" "vpc_random_int" {
  max = 100
  min = 1
}

resource "aws_vpc" "my_eks_vpc" {
  lifecycle {
    create_before_destroy = true
  }

  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "pht-dev-eks-vpc-${random_integer.vpc_random_int.result}"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}


resource "random_shuffle" "az_shuffle" {
  input = data.aws_availability_zones.available.names

  result_count = 10
}


resource "aws_subnet" "pht_public_subnets" {
  count = var.pub_sub_count

  vpc_id                  = aws_vpc.my_eks_vpc.id
  map_public_ip_on_launch = true

  cidr_block        = var.pub_sub_cidr[count.index]
  availability_zone = random_shuffle.az_shuffle.result[count.index]

  tags = {
    Name = "${local.name}-public-subnet-${count.index + 1}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_eks_vpc.id

  tags = {
    Name = "${local.name}-public-route-table"
  }
}



resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_eks_vpc.id

  tags = {
    Name = "${local.name}-igw"
  }
}


resource "aws_route_table_association" "public_rt_assoc" {
  count = var.pub_sub_count

  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.pht_public_subnets[count.index].id
}

resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public_route_table.id

  gateway_id             = aws_internet_gateway.my_igw.id
  destination_cidr_block = "0.0.0.0/0"

}

resource "aws_subnet" "pht_private_subnets" {
  count = var.prv_sub_count

  vpc_id = aws_vpc.my_eks_vpc.id

  cidr_block        = var.prv_sub_cidr[count.index]
  availability_zone = random_shuffle.az_shuffle.result[count.index]

  map_public_ip_on_launch = false

  tags = {
    Name = "eks-private-subnet-${count.index + 1}"
  }
}


resource "aws_default_route_table" "default_private_route_table" {
  default_route_table_id = aws_vpc.my_eks_vpc.default_route_table_id

  tags = {
    Name = "${local.name}-main-route-table-(private)"
  }
}


resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_eks_vpc.id

  tags = {
    Name = "${local.name}-private-route-table"
  }
}

resource "aws_eip" "nat_gw_eip" {
  depends_on = [ aws_internet_gateway.my_igw ]

  domain = "vpc"

  tags = {
    Name = "${local.name}-nat-gw-eip"
  }
}

resource "aws_nat_gateway" "my_nat_gateway" {
  depends_on = [aws_internet_gateway.my_igw]

  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.pht_public_subnets[0].id

  tags = {
    Name = "${local.name}-nat-gateway"
  }
}

resource "aws_route_table_association" "private_rt_assoc" {
  count = var.prv_sub_count

  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.pht_private_subnets[count.index].id
}

resource "aws_route" "private_route" {
  route_table_id = aws_route_table.private_route_table.id

  gateway_id             = aws_nat_gateway.my_nat_gateway.id
  destination_cidr_block = "0.0.0.0/0"

}


resource "aws_security_group" "cluster_sg" {
  for_each = var.security_groups

  vpc_id = aws_vpc.my_eks_vpc.id

  name        = each.value.name
  description = each.value.description
  tags        = each.value.tags

  dynamic "ingress" {
    for_each = each.value.ingress

    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = [ingress.value.cidr_blocks]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

