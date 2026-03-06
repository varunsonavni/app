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
