variable "name" {
  description = "Resource Prefix"
  type        = string
}

variable "tags" {
  description = "Resource Tags"
  type        = map(string)
}

variable "aws_vpc_id" {
  description = "AWS VPC ID"
  type        = string
}

variable "aws_allow_cidr" {
  description = "AWS Security Group Allow CIDR"
  type        = list(string)
}

variable "aws_ami" {
  description = "AWS AMI"
  type        = string
  default     = "ami-04876f29fd3a5e8ba"
}

variable "aws_instance_type" {
  description = "AWS Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "aws_public_subnet_ids" {
  description = "AWS Public Subnet IDs"
  type        = list(string)
}

variable "aws_keypair_name" {
  description = "AWS Instance Keypair name"
  type        = string
}
