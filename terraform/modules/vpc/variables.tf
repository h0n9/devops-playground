variable "name" {
  description = "Resource Prefix"
  type        = string
}

variable "tags" {
  description = "Resource Tags"
  type        = map(string)
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "aws_vpc_cidr" {
  description = "AWS VPC CIDR"
  type        = string
}

variable "aws_azs" {
  description = "AWS Availiability Zones"
  type        = list(string)
}

variable "aws_public_subnets" {
  description = "AWS Public Subnet"
  type        = list(string)
}

variable "aws_private_subnets" {
  description = "AWS Private Subnet"
  type        = list(string)
}
