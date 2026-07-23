#########################################
# Security Hub Account
#########################################

output "securityhub_account_id" {
  description = "AWS Security Hub Account ID"
  value       = aws_securityhub_account.this.id
}

output "securityhub_account_arn" {
  description = "AWS Security Hub Account ARN"
  value       = aws_securityhub_account.this.arn
}

#########################################
# Security Hub Configuration
#########################################

output "default_standards_enabled" {
  description = "Default Security Standards Status"
  value       = var.enable_default_standards
}

output "auto_enable_controls" {
  description = "Auto Enable Controls Status"
  value       = var.auto_enable_controls
}

output "control_finding_generator" {
  description = "Control Finding Generator"
  value       = var.control_finding_generator
}

#########################################
# Standards
#########################################

output "standards_subscription_count" {
  description = "Number of Security Standards Subscriptions"
  value       = length(var.standards_subscription_arns)
}

#########################################
# Product Integrations
#########################################

output "product_integration_count" {
  description = "Number of Product Integrations"
  value       = length(var.product_subscription_arns)
}

#########################################
# Member Accounts
#########################################

output "member_account_count" {
  description = "Number of Member Accounts"
  value       = length(var.member_account_ids)
}

#########################################
# Organization
#########################################

output "organization_configuration_enabled" {
  description = "Organization Configuration Status"
  value       = var.organization_configuration
}

#########################################
# Module Summary
#########################################

output "securityhub_summary" {
  description = "AWS Security Hub Module Summary"

  value = {
    securityhub_account_id          = aws_securityhub_account.this.id
    securityhub_account_arn         = aws_securityhub_account.this.arn
    default_standards_enabled       = var.enable_default_standards
    auto_enable_controls            = var.auto_enable_controls
    control_finding_generator       = var.control_finding_generator
    standards_subscription_count    = length(var.standards_subscription_arns)
    product_integration_count       = length(var.product_subscription_arns)
    member_account_count            = length(var.member_account_ids)
    organization_configuration      = var.organization_configuration
  }
}
