terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  access_key=var.aws_access_key
  secret_key=var.aws_secret_key
}

module "vpc" {
  source   = "./modules/vpc"
  env      = var.env
  vpc_cidr = var.vpc_cidr
}

module "subnet" {
  source              = "./modules/subnet"
  myapp-vpc-id        = module.vpc.vpc-id.id
  gw-id               = module.vpc.gw-id.id
  avail_zone          = var.avail_zone
  env                 = var.env
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_cidr  = var.public_subnet_cidr
}

module "ec2-instance" {
  source = "./modules/ec2"

  avail_zone           = var.avail_zone
  aws-public-subnet-id = module.subnet.aws-subnet.id
  env                  = var.env
  instance_type        = var.instance_type
  myapp-vpc-id         = module.vpc.vpc-id.id
}
