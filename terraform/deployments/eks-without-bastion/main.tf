locals {
  cluster_name = "h0n9-cluster"
  region       = "ap-northeast-2"
}

module "vpc" {
  source = "../../modules/vpc-cheap"

  name = "h0n9-vpc"
  tags = {
    "terraform-managed" = "true"
  }

  aws_region          = local.region
  aws_vpc_cidr        = "192.168.0.0/16"
  aws_azs             = ["ap-northeast-2a", "ap-northeast-2c"]
  aws_public_subnets  = ["192.168.1.0/24", "192.168.2.0/24"]
  aws_private_subnets = ["192.168.101.0/24", "192.168.102.0/24"]
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = local.cluster_name
  vpc_id          = module.vpc.aws_vpc_id
  subnets         = module.vpc.aws_private_subnet_ids
  cluster_version = "1.20"

  node_groups = {
    eks_nodes = {
      desired_capacity = 3
      max_capacity     = 5
      min_capacity     = 3
      key_name         = "h0n9-eks-key"
      ami_type         = "AL2_x86_64"
      instance_types   = ["t2.micro"]
    }
  }
  manage_aws_auth = false
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
