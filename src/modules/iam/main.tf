data "aws_iam_policy_document" "assume" {
  statement {
    actions = var.assume_role_policy_actions

    principals {
      type        = var.assume_role_policy_principals_type
      identifiers = var.assume_role_policy_principals_identifiers
    }
  }
}

resource "aws_iam_role" "this" {
  name               = "${var.prefix}-role-${var.name}"
  path               = var.path
  assume_role_policy = data.aws_iam_policy_document.assume.json
}

resource "aws_iam_role_policy_attachment" "attachment" {
  count = length(var.iam_role_managed_policy_arns) > 0 ? length(var.iam_role_managed_policy_arns) : 0

  role       = aws_iam_role.this.name
  policy_arn = element(var.iam_role_managed_policy_arns, count.index)
}

resource "aws_iam_instance_profile" "profile" {
  count = var.create_instabce_profile ? 1 : 0

  name = "${var.prefix}-ec2-instance-profile"
  role = aws_iam_role.this.name
}

data "aws_iam_policy_document" "custom" {
  dynamic "statement" {
    for_each = var.allow_iam_role_policies

    content {
      effect    = "Allow"
      actions   = statement.value[0]
      resources = statement.value[1]
    }
  }

  dynamic "statement" {
    for_each = var.deny_iam_role_policies

    content {
      effect    = "Deny"
      actions   = statement.value[0]
      resources = statement.value[1]
    }
  }
}

resource "aws_iam_policy" "custom" {
  count = length(var.allow_iam_role_policies) + length(var.deny_iam_role_policies) > 0 ? 1 : 0

  name   = "${var.prefix}-policy-custom-${var.name}"
  policy = data.aws_iam_policy_document.custom.json
}