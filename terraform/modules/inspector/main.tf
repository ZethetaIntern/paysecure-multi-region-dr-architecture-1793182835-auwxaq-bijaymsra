#########################################
# Amazon Inspector V2
#########################################

resource "aws_inspector2_enabler" "this" {

  count = var.enable_inspector ? 1 : 0

  account_ids = length(var.account_ids) > 0 ? var.account_ids : [
    data.aws_caller_identity.current.account_id
  ]

  resource_types = compact([
    var.enable_ec2_scanning ? "EC2" : null,
    var.enable_ecr_scanning ? "ECR" : null,
    var.enable_lambda_scanning ? "LAMBDA" : null,
    var.enable_lambda_code_scanning ? "LAMBDA_CODE" : null
  ])

}

#########################################
# Organization Configuration
#########################################

resource "aws_inspector2_organization_configuration" "this" {

  count = var.organization_configuration ? 1 : 0

  auto_enable {

    ec2 = var.auto_enable

    ecr = var.auto_enable

    lambda = var.auto_enable

    lambda_code = var.auto_enable

  }

}

#########################################
# Current AWS Account
#########################################

data "aws_caller_identity" "current" {}
