#########################################
# Security Hub Account
#########################################

resource "aws_securityhub_account" "this" {

  enable_default_standards =
    var.enable_default_standards

  auto_enable_controls =
    var.auto_enable_controls

  control_finding_generator =
    var.control_finding_generator

}

#########################################
# Security Standards
#########################################

resource "aws_securityhub_standards_subscription" "this" {

  for_each = toset(
    var.standards_subscription_arns
  )

  standards_arn = each.value

  depends_on = [
    aws_securityhub_account.this
  ]

}

#########################################
# Organization Configuration
#########################################

resource "aws_securityhub_organization_configuration" "this" {

  count = var.organization_configuration ? 1 : 0

  auto_enable = true

  auto_enable_standards =
    var.enable_default_standards ? "DEFAULT" : "NONE"

  depends_on = [
    aws_securityhub_account.this
  ]

}

#########################################
# Product Integrations
#########################################

resource "aws_securityhub_product_subscription" "this" {

  for_each = toset(
    var.product_subscription_arns
  )

  product_arn = each.value

  depends_on = [
    aws_securityhub_account.this
  ]

}

#########################################
# Member Accounts
#########################################

resource "aws_securityhub_member" "this" {

  for_each = toset(
    var.member_account_ids
  )

  account_id = each.value

  email = "${each.value}@example.com"

  invite = true

  depends_on = [
    aws_securityhub_account.this
  ]

}
