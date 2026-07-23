#########################################
# Web ACL
#########################################

output "web_acl_id" {
  description = "AWS WAF Web ACL ID"
  value       = aws_wafv2_web_acl.this.id
}

output "web_acl_arn" {
  description = "AWS WAF Web ACL ARN"
  value       = aws_wafv2_web_acl.this.arn
}

output "web_acl_name" {
  description = "AWS WAF Web ACL Name"
  value       = aws_wafv2_web_acl.this.name
}

output "web_acl_capacity" {
  description = "Web ACL Capacity (WCUs)"
  value       = aws_wafv2_web_acl.this.capacity
}

output "web_acl_scope" {
  description = "Web ACL Scope"
  value       = aws_wafv2_web_acl.this.scope
}

#########################################
# IP Sets
#########################################

output "allow_ip_set_arn" {
  description = "Allow IP Set ARN"

  value = (
    length(aws_wafv2_ip_set.allow) > 0
    ? aws_wafv2_ip_set.allow[0].arn
    : null
  )
}

output "block_ip_set_arn" {
  description = "Block IP Set ARN"

  value = (
    length(aws_wafv2_ip_set.block) > 0
    ? aws_wafv2_ip_set.block[0].arn
    : null
  )
}

#########################################
# Managed Rule Groups
#########################################

output "managed_rule_groups" {
  description = "Configured AWS Managed Rule Groups"

  value = [
    for rule in var.managed_rule_groups : {
      name        = rule.name
      vendor_name = rule.vendor_name
      priority    = rule.priority
    }
  ]
}

#########################################
# Rate Limiting
#########################################

output "rate_limit_configuration" {
  description = "Rate Limiting Configuration"

  value = {
    enabled = true
    limit   = var.rate_limit
  }
}

#########################################
# Visibility
#########################################

output "cloudwatch_metrics_enabled" {
  description = "CloudWatch Metrics Enabled"
  value       = var.cloudwatch_metrics_enabled
}

output "sampled_requests_enabled" {
  description = "Sampled Requests Enabled"
  value       = var.sampled_requests_enabled
}

#########################################
# Module Summary
#########################################

output "waf_summary" {
  description = "AWS WAF Module Summary"

  value = {
    web_acl_name              = aws_wafv2_web_acl.this.name
    scope                     = aws_wafv2_web_acl.this.scope
    capacity                  = aws_wafv2_web_acl.this.capacity
    managed_rule_group_count  = length(var.managed_rule_groups)
    rate_limit                = var.rate_limit
    allow_ip_set_configured   = length(aws_wafv2_ip_set.allow) > 0
    block_ip_set_configured   = length(aws_wafv2_ip_set.block) > 0
    metrics_enabled           = var.cloudwatch_metrics_enabled
    sampled_requests_enabled  = var.sampled_requests_enabled
  }
}
