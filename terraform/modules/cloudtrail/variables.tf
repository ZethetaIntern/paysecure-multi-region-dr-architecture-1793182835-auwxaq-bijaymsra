#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# CloudTrail
#########################################

variable "trail_name" {
  description = "AWS CloudTrail Trail Name"
  type        = string
}

#########################################
# Storage
#########################################

variable "s3_bucket_name" {
  description = "S3 Bucket Name for CloudTrail Logs"
  type        = string
}

variable "kms_key_id" {
  description = "KMS Key ARN or Alias"
  type        = string
  default     = null
}

#########################################
# CloudWatch Logs
#########################################

variable "cloudwatch_log_group_arn" {
  description = "CloudWatch Log Group ARN"
  type        = string
  default     = null
}

variable "cloudwatch_logs_role_arn" {
  description = "IAM Role ARN for CloudWatch Logs"
  type        = string
  default     = null
}

#########################################
# Trail Configuration
#########################################

variable "is_multi_region_trail" {
  description = "Enable Multi-Region Trail"
  type        = bool
  default     = true
}

variable "include_global_service_events" {
  description = "Include Global Service Events"
  type        = bool
  default     = true
}

variable "enable_log_file_validation" {
  description = "Enable Log File Integrity Validation"
  type        = bool
  default     = true
}

variable "is_organization_trail" {
  description = "Enable Organization Trail"
  type        = bool
  default     = false
}

#########################################
# Insight Selectors
#########################################

variable "enable_api_call_rate_insight" {
  description = "Enable API Call Rate Insight"
  type        = bool
  default     = true
}

variable "enable_api_error_rate_insight" {
  description = "Enable API Error Rate Insight"
  type        = bool
  default     = true
}

#########################################
# Event Selectors
#########################################

variable "read_write_type" {
  description = "Read/Write Event Type"
  type        = string
  default     = "All"
}

variable "include_management_events" {
  description = "Include Management Events"
  type        = bool
  default     = true
}

#########################################
# Data Events
#########################################

variable "data_resources" {
  description = "CloudTrail Data Resources"

  type = list(object({
    type   = string
    values = list(string)
  }))

  default = []
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)
}
