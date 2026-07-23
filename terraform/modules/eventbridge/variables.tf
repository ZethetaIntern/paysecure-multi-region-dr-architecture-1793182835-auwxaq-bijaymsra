#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# Event Bus
#########################################

variable "event_bus_name" {
  description = "Amazon EventBridge Event Bus Name"
  type        = string
  default     = "default"
}

#########################################
# Event Rule
#########################################

variable "rule_name" {
  description = "EventBridge Rule Name"
  type        = string
}

variable "description" {
  description = "EventBridge Rule Description"
  type        = string
  default     = "Managed by Terraform"
}

variable "event_pattern" {
  description = "JSON Event Pattern"
  type        = string
  default     = null
}

variable "schedule_expression" {
  description = "Schedule Expression"
  type        = string
  default     = null
}

variable "state" {
  description = "Rule State"
  type        = string
  default     = "ENABLED"
}

#########################################
# Targets
#########################################

variable "target_arns" {
  description = "List of EventBridge Target ARNs"
  type        = list(string)
  default     = []
}

variable "target_role_arn" {
  description = "IAM Role ARN for EventBridge Targets"
  type        = string
  default     = null
}

#########################################
# Dead Letter Queue
#########################################

variable "dead_letter_queue_arn" {
  description = "Dead Letter Queue ARN"
  type        = string
  default     = null
}

#########################################
# Retry Policy
#########################################

variable "maximum_event_age_in_seconds" {
  description = "Maximum Event Age (Seconds)"
  type        = number
  default     = 3600
}

variable "maximum_retry_attempts" {
  description = "Maximum Retry Attempts"
  type        = number
  default     = 3
}

#########################################
# Event Archive
#########################################

variable "enable_archive" {
  description = "Enable Event Archive"
  type        = bool
  default     = false
}

variable "archive_name" {
  description = "Event Archive Name"
  type        = string
  default     = null
}

variable "archive_retention_days" {
  description = "Archive Retention Period (Days)"
  type        = number
  default     = 90
}

#########################################
# Logging
#########################################

variable "log_retention_in_days" {
  description = "CloudWatch Log Retention Period"
  type        = number
  default     = 30
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)
}
