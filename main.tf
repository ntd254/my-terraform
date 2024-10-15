provider "aws" {
  region     = "ap-southeast-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

module "ec2-instance" {
  source            = "./modules/ec2"
  name              = "web"
  ami_id            = "ami-03fa85deedfcac80b"
  instance_type     = "t2.micro"
  security_group_id = module.vpc.security_group_id
}

module "vpc" {
  source            = "./modules/vpc"
  cidr_block        = "10.0.0.0/16"
  subnet_cidr_block = "10.0.1.0/24"
}
