#########################################
# Event Bus
#########################################

output "event_bus_id" {
  description = "Amazon EventBridge Event Bus ID"
  value       = aws_cloudwatch_event_bus.this.id
}

output "event_bus_name" {
  description = "Amazon EventBridge Event Bus Name"
  value       = aws_cloudwatch_event_bus.this.name
}

output "event_bus_arn" {
  description = "Amazon EventBridge Event Bus ARN"
  value       = aws_cloudwatch_event_bus.this.arn
}

#########################################
# Event Rule
#########################################

output "event_rule_name" {
  description = "EventBridge Rule Name"
  value       = aws_cloudwatch_event_rule.this.name
}

output "event_rule_arn" {
  description = "EventBridge Rule ARN"
  value       = aws_cloudwatch_event_rule.this.arn
}

output "event_rule_state" {
  description = "EventBridge Rule State"
  value       = aws_cloudwatch_event_rule.this.state
}

#########################################
# Event Targets
#########################################

output "target_arns" {
  description = "Configured Event Target ARNs"
  value       = var.target_arns
}

output "target_count" {
  description = "Number of Configured Event Targets"
  value       = length(var.target_arns)
}

#########################################
# Event Archive
#########################################

output "archive_arn" {
  description = "Event Archive ARN"
  value = var.enable_archive ? aws_cloudwatch_event_archive.this[0].arn : null
}

output "archive_name" {
  description = "Event Archive Name"
  value = var.enable_archive ? aws_cloudwatch_event_archive.this[0].name : null
}

#########################################
# CloudWatch Logs
#########################################

output "log_group_name" {
  description = "CloudWatch Log Group Name"
  value       = aws_cloudwatch_log_group.this.name
}

#########################################
# Module Summary
#########################################

output "eventbridge_summary" {
  description = "Amazon EventBridge Module Summary"

  value = {
    event_bus_name       = aws_cloudwatch_event_bus.this.name
    event_bus_arn        = aws_cloudwatch_event_bus.this.arn
    rule_name            = aws_cloudwatch_event_rule.this.name
    rule_state           = aws_cloudwatch_event_rule.this.state
    target_count         = length(var.target_arns)
    archive_enabled      = var.enable_archive
    archive_name         = var.enable_archive ? aws_cloudwatch_event_archive.this[0].name : null
    log_group_name       = aws_cloudwatch_log_group.this.name
    retry_attempts       = var.maximum_retry_attempts
    max_event_age        = var.maximum_event_age_in_seconds
  }
}
