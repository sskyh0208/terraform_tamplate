module "example" {
    env = local.env
    product_name = var.product_name

    prefix = "${local.env}-${var.product_name}"
}