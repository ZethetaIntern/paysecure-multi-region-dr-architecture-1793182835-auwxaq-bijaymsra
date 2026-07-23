#########################################
# CloudTrail
#########################################

output "trail_id" {
  description = "AWS CloudTrail Trail ID"
  value       = aws_cloudtrail.this.id
}

output "trail_arn" {
  description = "AWS CloudTrail Trail ARN"
  value       = aws_cloudtrail.this.arn
}

output "trail_name" {
  description = "AWS CloudTrail Trail Name"
  value       = aws_cloudtrail.this.name
}

output "home_region" {
  description = "CloudTrail Home Region"
  value       = aws_cloudtrail.this.home_region
}

#########################################
# Storage
#########################################

output "s3_bucket_name" {
  description = "S3 Bucket Used for CloudTrail Logs"
  value       = var.s3_bucket_name
}

#########################################
# CloudWatch Logs
#########################################

output "cloudwatch_log_group_arn" {
  description = "CloudWatch Log Group ARN"
  value       = var.cloudwatch_log_group_arn
}

#########################################
# Trail Configuration
#########################################

output "multi_region_trail" {
  description = "Whether Multi-Region Trail is Enabled"
  value       = aws_cloudtrail.this.is_multi_region_trail
}

output "organization_trail" {
  description = "Whether Organization Trail is Enabled"
  value       = aws_cloudtrail.this.is_organization_trail
}

output "log_file_validation_enabled" {
  description = "Whether Log File Validation is Enabled"
  value       = aws_cloudtrail.this.enable_log_file_validation
}

#########################################
# Insight Selectors
#########################################

output "insight_selectors" {
  description = "Configured Insight Selectors"

  value = [
    for selector in aws_cloudtrail.this.insight_selector :
    selector.insight_type
  ]
}

#########################################
# Event Selector Configuration
#########################################

output "event_selector_configuration" {
  description = "CloudTrail Event Selector Configuration"

  value = {
    read_write_type             = var.read_write_type
    include_management_events   = var.include_management_events
    data_resource_count         = length(var.data_resources)
  }
}

#########################################
# Module Summary
#########################################

output "cloudtrail_summary" {
  description = "AWS CloudTrail Module Summary"

  value = {
    trail_name                  = aws_cloudtrail.this.name
    trail_arn                   = aws_cloudtrail.this.arn
    home_region                 = aws_cloudtrail.this.home_region
    multi_region_trail          = aws_cloudtrail.this.is_multi_region_trail
    organization_trail          = aws_cloudtrail.this.is_organization_trail
    log_file_validation         = aws_cloudtrail.this.enable_log_file_validation
    management_events           = var.include_management_events
    data_resource_count         = length(var.data_resources)
    insight_selector_count      = length(local.insight_types)
    s3_bucket_name              = var.s3_bucket_name
  }
}
