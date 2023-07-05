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
    }
}