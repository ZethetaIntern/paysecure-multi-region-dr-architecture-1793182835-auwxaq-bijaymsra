#########################################
# Dashboard
#########################################

output "dashboard_name" {
  description = "CloudWatch Dashboard Name"
  value       = aws_cloudwatch_dashboard.this.dashboard_name
}

output "dashboard_arn" {
  description = "CloudWatch Dashboard ARN"

  value = format(
    "arn:aws:cloudwatch::%s:dashboard/%s",
    data.aws_caller_identity.current.account_id,
    aws_cloudwatch_dashboard.this.dashboard_name
  )
}

#########################################
# Log Groups
#########################################

output "log_group_names" {
  description = "CloudWatch Log Group Names"

  value = [
    for lg in aws_cloudwatch_log_group.logs : lg.name
  ]
}

output "log_group_arns" {
  description = "CloudWatch Log Group ARNs"

  value = [
    for lg in aws_cloudwatch_log_group.logs : lg.arn
  ]
}

output "log_retention_days" {
  description = "Configured Log Retention"

  value = var.log_retention_days
}

#########################################
# CPU Alarm
#########################################

output "cpu_alarm_name" {
  description = "CPU Alarm Name"
  value       = aws_cloudwatch_metric_alarm.cpu.alarm_name
}

output "cpu_alarm_arn" {
  description = "CPU Alarm ARN"
  value       = aws_cloudwatch_metric_alarm.cpu.arn
}

#########################################
# Memory Alarm
#########################################

output "memory_alarm_name" {
  description = "Memory Alarm Name"
  value       = aws_cloudwatch_metric_alarm.memory.alarm_name
}

output "memory_alarm_arn" {
  description = "Memory Alarm ARN"
  value       = aws_cloudwatch_metric_alarm.memory.arn
}

#########################################
# Disk Alarm
#########################################

output "disk_alarm_name" {
  description = "Disk Alarm Name"
  value       = aws_cloudwatch_metric_alarm.disk.alarm_name
}

output "disk_alarm_arn" {
  description = "Disk Alarm ARN"
  value       = aws_cloudwatch_metric_alarm.disk.arn
}

#########################################
# Network Alarm
#########################################

output "network_alarm_name" {
  description = "Network Alarm Name"
  value       = aws_cloudwatch_metric_alarm.network.alarm_name
}

output "network_alarm_arn" {
  description = "Network Alarm ARN"
  value       = aws_cloudwatch_metric_alarm.network.arn
}

#########################################
# Monitoring Summary
#########################################

output "monitoring_summary" {
  description = "CloudWatch Monitoring Summary"

  value = {
    dashboard            = aws_cloudwatch_dashboard.this.dashboard_name
    total_log_groups     = length(aws_cloudwatch_log_group.logs)
    cpu_alarm            = aws_cloudwatch_metric_alarm.cpu.alarm_name
    memory_alarm         = aws_cloudwatch_metric_alarm.memory.alarm_name
    disk_alarm           = aws_cloudwatch_metric_alarm.disk.alarm_name
    network_alarm        = aws_cloudwatch_metric_alarm.network.alarm_name
    log_retention_days   = var.log_retention_days
  }
}

#########################################
# AWS Account
#########################################

data "aws_caller_identity" "current" {}
