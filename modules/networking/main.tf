resource "aws_vpc" "main" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.name
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "${var.name}-igw"
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "public" {
  count             = length(var.pub_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.pub_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name      = format("${var.name}-public-%s", element(var.azs, count.index))
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.pri_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.pri_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name      = format("${var.name}-private-%s", element(var.azs, count.index))
    ManagedBy = "Terraform"
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name      = "${var.name}-public"
    ManagedBy = "Terraform"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.pub_subnets)

  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}
