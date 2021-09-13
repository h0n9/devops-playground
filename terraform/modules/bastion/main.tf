# outside -(22)-> bastion
resource "aws_security_group" "to-bastion" {
  name   = "from-bastion"
  vpc_id = var.aws_vpc_id

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = var.aws_allow_cidr
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    "Name" = format("%s-%s", var.name, "security-group-to-bastion")
  })
}

# bastion -(22)-> private subnet
resource "aws_security_group" "from-bastion" {
  name   = "to-bastion"
  vpc_id = var.aws_vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.to-bastion.id]
  }

  tags = merge(var.tags, {
    "Name" = format("%s-%s", var.name, "security-group-from-bastion")
  })
}

resource "aws_instance" "bastion" {
  count = length(var.aws_public_subnet_ids)

  ami                    = var.aws_ami
  instance_type          = var.aws_instance_type
  subnet_id              = var.aws_public_subnet_ids[count.index]
  key_name               = var.aws_keypair_name
  vpc_security_group_ids = [aws_security_group.to-bastion.id]

  tags = merge(var.tags, {
    "Name" = format("%s-%s-%d", var.name, "instance", count.index)
  })
}
