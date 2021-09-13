resource "aws_vpc" "this" {
  cidr_block           = var.aws_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = merge(var.tags, {
    "Name" = format("%s-%s", var.name, "vpc")
  })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    "Name" = format("%s-%s", var.name, "igw")
  })
}

resource "aws_eip" "this" {
  depends_on = [
    aws_internet_gateway.this
  ]

  count = length(var.aws_azs)

  vpc = true

  tags = merge(var.tags, {
    "Name" = format("%s-%s-%s", var.name, "eip", var.aws_azs[count.index])
  })
}

resource "aws_subnet" "public" {
  count = length(var.aws_public_subnets)

  cidr_block              = var.aws_public_subnets[count.index]
  vpc_id                  = aws_vpc.this.id
  availability_zone       = var.aws_azs[count.index]
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    "Name"                   = format("%s-%s-%s", var.name, "subnet-public", var.aws_azs[count.index])
    "kubernetes.io/role/elb" = 1
  })
}

resource "aws_subnet" "private" {
  count = length(var.aws_private_subnets)

  cidr_block        = var.aws_private_subnets[count.index]
  vpc_id            = aws_vpc.this.id
  availability_zone = var.aws_azs[count.index]

  tags = merge(var.tags, {
    "Name"                            = format("%s-%s-%s", var.name, "subnet-private", var.aws_azs[count.index])
    "kubernetes.io/role/internal-elb" = 1
  })
}

resource "aws_nat_gateway" "this" {
  count = length(var.aws_azs)

  allocation_id = aws_eip.this.*.id[count.index]
  subnet_id     = aws_subnet.public.*.id[count.index]

  tags = merge(var.tags, {
    "Name" = format("%s-%s-%s", var.name, "nat-gw", var.aws_azs[count.index])
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(var.tags, {
    "Name" = format("%s-%s", var.name, "route-table-public")
  })
}

resource "aws_route_table" "private" {
  count = length(var.aws_azs)

  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.*.id[count.index]
  }

  tags = merge(var.tags, {
    "Name" = format("%s-%s-%s", var.name, "route-table-private", var.aws_azs[count.index])
  })
}

resource "aws_route_table_association" "public" {
  count = length(var.aws_public_subnets)

  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public.*.id[count.index]
}

resource "aws_route_table_association" "private" {
  count = length(var.aws_azs)

  route_table_id = aws_route_table.private.*.id[count.index]
  subnet_id      = aws_subnet.private.*.id[count.index]
}
