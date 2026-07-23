#########################################
# Inspector
#########################################

output "inspector_enabled" {
  description = "Amazon Inspector Enablement Status"
  value       = var.enable_inspector
}

output "account_ids" {
  description = "AWS Account IDs Enabled for Inspector"

  value = length(var.account_ids) > 0 ? var.account_ids : [
    data.aws_caller_identity.current.account_id
  ]
}

output "enabled_resource_types" {
  description = "Inspector Enabled Resource Types"

  value = compact([
    var.enable_ec2_scanning ? "EC2" : null,
    var.enable_ecr_scanning ? "ECR" : null,
    var.enable_lambda_scanning ? "LAMBDA" : null,
    var.enable_lambda_code_scanning ? "LAMBDA_CODE" : null
  ])
}

#########################################
# Resource Scanning
#########################################

output "ec2_scanning_enabled" {
  description = "EC2 Scanning Status"
  value       = var.enable_ec2_scanning
}

output "ecr_scanning_enabled" {
  description = "Amazon ECR Scanning Status"
  value       = var.enable_ecr_scanning
}

output "lambda_scanning_enabled" {
  description = "Lambda Scanning Status"
  value       = var.enable_lambda_scanning
}

output "lambda_code_scanning_enabled" {
  description = "Lambda Code Scanning Status"
  value       = var.enable_lambda_code_scanning
}

#########################################
# Organization Configuration
#########################################

output "organization_configuration_enabled" {
  description = "Organization Configuration Status"
  value       = var.organization_configuration
}

output "auto_enable" {
  description = "Inspector Auto Enable Status"
  value       = var.auto_enable
}

#########################################
# Module Summary
#########################################

output "inspector_summary" {
  description = "Amazon Inspector Module Summary"

  value = {
    inspector_enabled                 = var.enable_inspector
    account_count                     = length(length(var.account_ids) > 0 ? var.account_ids : [data.aws_caller_identity.current.account_id])
    ec2_scanning                      = var.enable_ec2_scanning
    ecr_scanning                      = var.enable_ecr_scanning
    lambda_scanning                   = var.enable_lambda_scanning
    lambda_code_scanning              = var.enable_lambda_code_scanning
    organization_configuration        = var.organization_configuration
    auto_enable                       = var.auto_enable
    enabled_resource_types            = compact([
      var.enable_ec2_scanning ? "EC2" : null,
      var.enable_ecr_scanning ? "ECR" : null,
      var.enable_lambda_scanning ? "LAMBDA" : null,
      var.enable_lambda_code_scanning ? "LAMBDA_CODE" : null
    ])
  }
}
