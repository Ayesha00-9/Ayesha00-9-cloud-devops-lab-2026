module "vpc" {
  source = "./modules/VPC"

  vpc_cidr = var.vpc_cidr
}

module "networking" {
  source = "./modules/networking"

  vpc_id              = module.vpc.vpc_id
  availability_zone   = var.availability_zone
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "security_group" {
  source = "./modules/security-group"

  vpc_id = module.vpc.vpc_id
}
module "iam" {
  source = "./modules/IAM"

  project_name     = var.project_name
  jenkins_username = var.jenkins_username
  jenkins_password = var.jenkins_password
}
module "ec2" {
  source = "./modules/EC2"

  project_name  = var.project_name
  ami_id        = var.ami_id
  instance_type = var.instance_type

  public_subnet_id  = module.networking.public_subnet_id
  private_subnet_id = module.networking.private_subnet_id

  bastion_security_group_id = module.security_group.bastion_security_group_id
  app_security_group_id     = module.security_group.app_security_group_id

  ec2_instance_profile_name = module.iam.ec2_instance_profile_name
}