#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# CloudWatch Logs
#########################################

variable "log_group_names" {
  description = "List of CloudWatch Log Group Names"
  type        = list(string)
  default     = []
}

variable "log_retention_days" {
  description = "CloudWatch Log Retention Period"
  type        = number
  default     = 30
}

variable "kms_key_arn" {
  description = "KMS Key ARN for Log Encryption"
  type        = string
}

#########################################
# Dashboard
#########################################

variable "dashboard_name" {
  description = "CloudWatch Dashboard Name"
  type        = string
  default     = "paysecure-dashboard"
}

#########################################
# SNS Notifications
#########################################

variable "sns_topic_arn" {
  description = "SNS Topic ARN for Alarm Notifications"
  type        = string
}

variable "alarm_email" {
  description = "Alarm Notification Email"
  type        = string
}

#########################################
# Alarm Thresholds
#########################################

variable "cpu_threshold" {
  description = "CPU Utilization Threshold"
  type        = number
  default     = 80
}

variable "memory_threshold" {
  description = "Memory Utilization Threshold"
  type        = number
  default     = 80
}

variable "disk_threshold" {
  description = "Disk Utilization Threshold"
  type        = number
  default     = 85
}

variable "network_threshold" {
  description = "Network Throughput Threshold (Bytes)"
  type        = number
  default     = 104857600
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)
}
