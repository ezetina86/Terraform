#------------------------------------------------------------
# Preparation for Terraform certification
# High availability server
# @author: Enrique Zetina
# Modules
# Provision:
# - Intenet gteway
# - XX Public Subnets
# - XX Private Subnets
# - XX NAT gateways in Public subnet to give Internet access from private subnet
#------------------------------------------------------------

data "aws_availability_zones" "available" {}

terraform {
  backend "s3" {
    bucket = "ez-it-terraform-remote-state"  //buckett to save
    key    = "dev/network/terraform.tfstate" //object to save
    region = "us-west-1"                     //region of the bucket
  }
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags       = merge(var.tags, { Name = "${var.env}-vpc" })
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.tags, { Name = "${var.env}-igw" })
}

resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidr)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidr, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags                    = merge(var.tags, { Name = "${var.env}-public-${count.index + 1}" })
}

resource "aws_route_table" "public_subnets" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = merge(var.tags, { Name = "${var.env}-route-public-subnets" })
}

resource "aws_route_table_association" "public_routes" {
  count          = length(aws_subnet.public_subnets[*].id)
  route_table_id = aws_route_table.public_subnets.id
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
}

# NAT Gateways

resource "aws_eip" "nat" {
  count = length(var.private_subnet_cidr)
  vpc   = true
  tags  = merge(var.tags, { Name = "${var.env}-nat-gw-${count.index + 1}" })
}

resource "aws_nat_gateway" "nat" {
  count         = length(var.private_subnet_cidr)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id
  tags          = merge(var.tags, { Name = "${var.env}-nat-gw-${count.index + 1}" })
}

# Private Submnets

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidr, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags              = merge(var.tags, { Name = "${var.env}-private-${count.index + 1}" })
}

resource "aws_route_table" "private_subnets" {
  count  = length(var.private_subnet_cidr)
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = merge(var.tags, { Name = "${var.env}-route-private-subnets-${count.index + 1}" })
}

resource "aws_route_table_association" "private_routes" {
  count          = length(aws_subnet.private_subnets[*].id)
  route_table_id = aws_route_table.private_subnets[count.index].id
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
}
