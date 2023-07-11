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

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "enable_dns_support" {
  type = bool
  default = true
}

variable "enable_dns_hostnames" {
  type = bool
  default = true
}

variable "create_public_subnets" {
  type = bool
  default = true
}

variable "create_private_subnets" {
  type = bool
  default = false
}

variable "create_database_subnets" {
  type = bool
  default = false
}

variable "azs" {
  type    = list(string)
  default = []
}

variable "map_public_ip_on_launch" {
  type    = bool
  default = false
}