terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "networking" {
  source = "./modules/networking"

  project               = var.project
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  availability_zones    = var.availability_zones
}

module "security" {
  source = "./modules/security"

  project           = var.project
  vpc_id            = module.networking.vpc_id  
  web_ingress_rules = var.web_ingress_rules
  ssh_ingress_rules = var.ssh_ingress_rules
  bastion_ingress_rules = var.bastion_ingress_rules
}


module "compute" {
  source = "./modules/compute"

  project              = var.project
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = module.networking.private_subnet_ids[0]
  security_group_ids   = [
    module.security.web_sg_id,
    module.security.ssh_sg_id
  ]
  key_name             = var.key_name
  tags                = var.tags
}

# module "bastion" {
#   source        = "./modules/bastion"
#   project       = var.project
#   ami_id        = var.bastion_ami
#   instance_type = var.instance_type
#   key_name      = var.key_name
#   subnet_id     = module.networking.public_subnet_ids[0]
#   tags          = var.tags
#   vpc_id        = module.networking.vpc_id
#   security_group_ids = [module.security.bastion_sg_id] 
# }

module "bastion" {
  source = "./modules/bastion"

  project            = var.project
  ami_id             = var.bastion_ami
  instance_type      = var.instance_type
  key_name           = var.key_name
  subnet_id          = module.networking.public_subnet_ids[0]
  security_group_ids = [module.security.bastion_sg_id]
  vpc_id        = module.networking.vpc_id
  tags               = var.tags
}

