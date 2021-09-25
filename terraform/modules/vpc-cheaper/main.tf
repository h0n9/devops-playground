resource "aws_vpc" "this" {
  cidr_block           = var.aws_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = merge(var.tags, {
    "Name" = format("%s-%s", var.name, "vpc")
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
