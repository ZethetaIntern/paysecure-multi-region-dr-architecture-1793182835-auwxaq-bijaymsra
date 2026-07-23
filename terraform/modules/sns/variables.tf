#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# SNS Topic
#########################################

variable "topic_name" {
  description = "SNS Topic Name"
  type        = string
}

variable "display_name" {
  description = "SNS Display Name"
  type        = string
  default     = null
}

#########################################
# Encryption
#########################################

variable "kms_master_key_id" {
  description = "KMS Key ARN or Alias"
  type        = string
  default     = null
}

#########################################
# FIFO Configuration
#########################################

variable "fifo_topic" {
  description = "Enable FIFO Topic"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Enable Content-Based Deduplication"
  type        = bool
  default     = false
}

#########################################
# Delivery Policy
#########################################

variable "delivery_policy" {
  description = "SNS Delivery Policy (JSON)"
  type        = string
  default     = null
}

#########################################
# Archive Policy
#########################################

variable "archive_policy" {
  description = "SNS Archive Policy (JSON)"
  type        = string
  default     = null
}

#########################################
# Subscriptions
#########################################

variable "subscriptions" {
  description = "SNS Topic Subscriptions"

  type = list(object({
    protocol              = string
    endpoint              = string
    endpoint_auto_confirms = optional(bool, false)
    raw_message_delivery  = optional(bool, false)
    filter_policy         = optional(string)
  }))

  default = []
}

#########################################
# Feedback Configuration
#########################################

variable "http_success_feedback_role_arn" {
  description = "HTTP Success Feedback Role ARN"
  type        = string
  default     = null
}

variable "http_failure_feedback_role_arn" {
  description = "HTTP Failure Feedback Role ARN"
  type        = string
  default     = null
}

variable "http_success_feedback_sample_rate" {
  description = "HTTP Success Feedback Sample Rate"
  type        = number
  default     = 100
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)
}
