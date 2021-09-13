output "aws_vpc_id" {
  description = "AWS VPC ID"
  value       = aws_vpc.this.id
}

output "aws_vpc_cidr" {
  description = "AWS VPC CIDR"
  value       = aws_vpc.this.cidr_block
}

output "aws_internet_gateway_id" {
  description = "AWS Internet Gateway ID"
  value       = aws_internet_gateway.this.id
}

output "aws_eip_ids" {
  description = "AWS EIP IDs"
  value       = aws_eip.this.*.id
}

output "aws_public_subnet_ids" {
  description = "AWS Public Subnet IDs"
  value       = aws_subnet.public.*.id
}

output "aws_private_subnet_ids" {
  description = "AWS Private Subnet IDs"
  value       = aws_subnet.private.*.id
}

output "aws_nat_gateway_ids" {
  description = "AWS NAT Gateway IDs"
  value       = aws_nat_gateway.this.*.id
}

output "aws_route_table_private_id" {
  description = "AWS Private Route Table ID"
  value       = aws_route_table.private.*.id
}
