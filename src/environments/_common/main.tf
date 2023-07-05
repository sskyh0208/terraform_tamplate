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
}