module "vpc" {
  source = "../../modules/vpc"

  # common
  product_name = var.product_name

  # unique
  env                     = local.env
  prefix                  = "${local.env}-${var.product_name}"
  cidr                    = local.vpc.cidr
  enable_dns_support      = local.vpc.enable_dns_support
  enable_dns_hostnames    = local.vpc.enable_dns_hostnames
  create_public_subnets   = local.vpc.create_public_subnets
  create_private_subnets  = local.vpc.create_private_subnets
  create_database_subnets = local.vpc.create_database_subnets
  azs                     = local.vpc.azs
  map_public_ip_on_launch = local.vpc.map_public_ip_on_launch
}

module "public_sg" {
  source = "../../modules/security_group"

  # common
  product_name = var.product_name

  # unique
  env                     = local.env
  prefix                  = "${local.env}-${var.product_name}"
  vpc_id                  = module.vpc.vpc_id
  name                    = local.public_sg.name         
  ingress_cidr_blocks     = local.public_sg.ingress.cidr_blocks
  ingress_rules           = local.public_sg.ingress.rules
  egress_cidr_blocks      = local.public_sg.egress.cidr_blocks
  egress_rules            = local.public_sg.egress.rules
}