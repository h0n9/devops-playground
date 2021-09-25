output "aws_vpc_id" {
  description = "AWS VPC ID"
  value       = aws_vpc.this.id
}

output "aws_vpc_cidr" {
  description = "AWS VPC CIDR"
  value       = aws_vpc.this.cidr_block
}

output "aws_private_subnet_ids" {
  description = "AWS Private Subnet IDs"
  value       = aws_subnet.private.*.id
}
