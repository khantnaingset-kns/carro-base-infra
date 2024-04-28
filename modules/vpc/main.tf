locals {
  prefix = "${var.environment}-${var.project_name}"
}

resource "aws_vpc" "main_vpc" {
  cidr_block = var.main_vpc_cidr_range

  tags = {
    Name = "${local.prefix}-${var.vpc_name}"
  }
}


resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnets_cidr_ranges)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = element(tolist(var.public_subnets_cidr_ranges), count.index)
  availability_zone = element(tolist(var.azs), count.index)

  tags = {
    Name = "${local.prefix}-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnets_cidr_ranges)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = element(tolist(var.private_subnets_cidr_ranges), count.index)
  availability_zone = element(tolist(var.azs), count.index)

  tags = {
    Name = "${local.prefix}-private-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${local.prefix}-${var.vpc_name}-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${local.prefix}-${var.vpc_name}-public-route-table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${local.prefix}-${var.vpc_name}-private-route-table"
  }
}

resource "aws_eip" "nat_gw_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.main_igw]

  tags = {
    Name = "${local.prefix}-nat-gw-ip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name = "${local.prefix}-nat-gw"
  }
}


resource "aws_route" "public_internet_route" {
  route_table_id = aws_route_table.public_route_table.id
  gateway_id = aws_internet_gateway.main_igw.id
  destination_cidr_block = var.public_internet_cidr
}

resource "aws_route" "outbound_internet_route" {
  route_table_id = aws_route_table.private_route_table.id
  nat_gateway_id = aws_nat_gateway.nat_gw.id
  destination_cidr_block = var.public_internet_cidr
}

resource "aws_route_table_association" "internet_public_subnet_associations" {
  count          = length(var.public_subnets_cidr_ranges)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "internet_privte_subnet_associations" {
  count = length(var.public_subnets_cidr_ranges)
  subnet_id = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}