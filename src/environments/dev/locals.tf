data "aws_caller_identity" "current" {}

locals {
  env = "dev"
  account_id = data.aws_caller_identity.current.account_id

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
    ingress = [
      {
        rule              = "http"
        cidr_blocks       = [ "0.0.0.0/0" ]
      }
    ]
    egress = {
      rules             = [ "all-all" ]
      cidr_blocks       = [ "0.0.0.0/0" ]
      security_group_id = ""
    }
  }

  iam_role = {
    name = "lambda"
    path = "/"
    assume = {
      actions    = [ "sts:AssumeRole" ]
      principals = {
        type        = "Service"
        identifiers = [ "lambda.amazonaws.com" ]
      }
    }
    managed_policy_arns = [
      "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    ]
    custom = {
      # statement [[actions], [resources]] 不要な場合はなくてもよい
      allows = [
        [
          [ "s3:*" ],[ "arn:aws:s3:::hoge", "arn:aws:s3:::hoge/*" ]
        ],
      ]
      denies = [
        [
          [ "dynamodb:*" ], [ "arn:aws:dynamodb:ap-northeast-1:${local.account_id}:table/*"]
        ]
      ]
    },
    create_instabce_profile = false
  }
}