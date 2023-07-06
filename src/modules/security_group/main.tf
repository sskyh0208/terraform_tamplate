# ---------------------------
# SecurityGroup
# ---------------------------
resource "aws_security_group" "this" {
  name        = "${var.prefix}-sg-${var.name}"
  description = "Security Group for ${var.env} ${var.product_name} ${var.name}"
  vpc_id      = var.vpc_id
  
  tags = {
    Name    = "${var.prefix}-sg-${var.name}"
    Env     = var.env
    Product = var.product_name 
  }
}

resource "aws_security_group_rule" "ingress_rules" {
  count = length(var.ingress_rules) > 0 ? length(var.ingress_rules) : 0

  security_group_id        = aws_security_group.this.id
  type                     = "ingress"
  cidr_blocks              = length(var.ingress_cidr_blocks) > 0 ? var.ingress_cidr_blocks : null
  source_security_group_id = var.ingress_security_group_id != "" ? var.ingress_security_group_id : null
  description              = var.rules[var.ingress_rules[count.index]][3]

  from_port = var.rules[var.ingress_rules[count.index]][0]
  to_port   = var.rules[var.ingress_rules[count.index]][1]
  protocol  = var.rules[var.ingress_rules[count.index]][2]
}

resource "aws_security_group_rule" "egress_rules" {
  count = length(var.egress_rules) > 0 ? length(var.egress_rules) : 0

  security_group_id        = aws_security_group.this.id
  type                     = "egress"
  cidr_blocks              = length(var.egress_cidr_blocks) > 0 ? var.egress_cidr_blocks : null
  source_security_group_id = var.egress_security_group_id != "" ? var.egress_security_group_id : null
  description              = var.rules[var.egress_rules[count.index]][3]

  from_port = var.rules[var.egress_rules[count.index]][0]
  to_port   = var.rules[var.egress_rules[count.index]][1]
  protocol  = var.rules[var.egress_rules[count.index]][2]
}