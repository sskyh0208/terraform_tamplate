variable "product_name" {
  type    = string
  default = ""
}

variable "env" {
  type    = string
  default = ""
}

variable "prefix" {
  type    = string
  default = ""
}

variable "name" {
  type    = string
  default = ""
}

variable "path" {
  type    = string
  default = "/"
}

variable "assume_role_policy_actions" {
  type    = list(string)
  default = [ "sts:AssumeRole" ]
}

variable "assume_role_policy_principals_type" {
  type    = string
  default = "Service"
}

variable "assume_role_policy_principals_identifiers" {
  type    = list(string)
  default = []
}

variable "iam_role_managed_policy_arns" {
  type    = list(string)
  default = []
}

variable "create_instabce_profile" {
  type    = bool
  default = false
}

variable "allow_iam_role_policies" {
  type    = list(list(list(string)))
  default = []
}

variable "deny_iam_role_policies" {
  type    = list(list(list(string)))
  default = []
}