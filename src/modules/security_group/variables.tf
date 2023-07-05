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

variable "vpc_id" {
  type    = string
  default = ""
}

variable "ingress_cidr_blocks" {
  type    = list(string)
  default = []
}

variable "ingress_security_group_id" {
  type    = string
  default = ""
}

variable "ingress_rules" {
  type    = list(string)
  default = []
}

variable "egress_cidr_blocks" {
  type    = list(string)
  default = []
}

variable "egress_security_group_id" {
  type    = string
  default = ""
}

variable "egress_rules" {
  type    = list(string)
  default = []
}