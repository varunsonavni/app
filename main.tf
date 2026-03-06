locals {
  name_prefix = "${var.project_name}-${var.environment}"

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  public_subnets  = ["192.168.1.0/24", "192.168.2.0/24"]
  private_subnets = ["192.168.3.0/24", "192.168.4.0/24"]
}

################################################################################
# Networking
################################################################################

module "networking" {
  source = "./modules/networking"

  name_prefix     = local.name_prefix
  vpc_cidr        = var.vpc_cidr
  azs             = local.azs
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets
}

################################################################################
# Database
################################################################################

module "database" {
  source = "./modules/database"

  name_prefix        = local.name_prefix
  vpc_id             = module.networking.vpc_id
  vpc_cidr           = var.vpc_cidr
  private_subnet_ids = module.networking.private_subnet_ids
  db_username        = var.db_username
  db_password        = var.db_password
}

################################################################################
# Compute
################################################################################

module "compute" {
  source = "./modules/compute"

  name_prefix        = local.name_prefix
  vpc_id             = module.networking.vpc_id
  public_subnet_ids  = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids
}
