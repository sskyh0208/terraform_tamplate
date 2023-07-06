locals {
  env = "dev"

  vpc = {
    cidr                    = "10.8.0.0/16"
    enable_dns_support      = true
    enable_dns_hostnames    = true
    create_public_subnets   = true
    create_private_subnets  = false
    create_database_subnets = true
    azs                     = [ "ap-northeast-1a", "ap-northeast-1c" ]
    map_public_ip_on_launch = true
  }

  public_sg = {
    name    = "public"
    ingress = {
      cidr_blocks = [ "0.0.0.0/0" ]
      rules       = [ "http-80-tcp", "https-443-tcp" ]
    }
    egress = {
      cidr_blocks = [ "0.0.0.0/0" ]
      rules       = [ "all-all" ]
    }
  }
}