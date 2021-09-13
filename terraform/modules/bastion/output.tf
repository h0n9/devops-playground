output "instance_id" {
  description = "Bastion EC2 Instance IDs"
  value       = aws_instance.bastion.*.id
}

output "sg_to_bastion_id" {
  description = "Security Group to-bastion ID"
  value       = aws_security_group.to-bastion.id
}

output "sg_from_bastion_id" {
  description = "Security Group from-bastion ID"
  value       = aws_security_group.from-bastion.id
}
