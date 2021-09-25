terraform {
  required_version = ">= 1.0.6"
  required_providers {
    aws = ">= 3.57.0"
  }
}

provider "aws" {
  region = local.region
}
