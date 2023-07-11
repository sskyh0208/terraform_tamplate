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
  env                       = local.env
  prefix                    = "${local.env}-${var.product_name}"
  vpc_id                    = module.vpc.vpc_id
  name                      = local.public_sg.name         
  ingress_rules             = local.public_sg.ingress.rules
  ingress_cidr_blocks       = lookup(local.public_sg.ingress, "cidr_blocks", [])       # 依存関係ある場合はここに記述 [ module.ec2.eip ]
  ingress_security_group_id = lookup(local.public_sg.ingress, "security_group_id", "") # 依存関係ある場合はここに記述 module.hoge.id
  egress_rules              = local.public_sg.egress.rules
  egress_cidr_blocks        = lookup(local.public_sg.egress, "cidr_blocks", [])       # 依存関係ある場合はここに記述 [ module.ec2.eip ]
  egress_security_group_id  = lookup(local.public_sg.egress, "security_group_id", "") # 依存関係ある場合はここに記述 module.hoge.id
}

module "iam_role" {
  source = "../../modules/iam"

  # common
  product_name = var.product_name

  # unique
  env                                       = local.env
  prefix                                    = "${local.env}-${var.product_name}"
  name                                      = local.iam_role.name
  path                                      = local.iam_role.path
  assume_role_policy_actions                = local.iam_role.assume.actions
  assume_role_policy_principals_type        = local.iam_role.assume.principals.type
  assume_role_policy_principals_identifiers = local.iam_role.assume.principals.identifiers
  iam_role_managed_policy_arns              = local.iam_role.managed_policy_arns
  create_instabce_profile                   = local.iam_role.create_instabce_profile
  allow_iam_role_policies                   = concat(
    lookup(local.iam_role, "custom.allows", []),
    [] # 依存関係がある場合はここに記述 [[actions],[resurces]]
  )
  deny_iam_role_policies                    = concat(
    lookup(local.iam_role, "custom.denies", []),
    [] # 依存関係がある場合はここに記述 [[actions],[resurces]]
  )
}