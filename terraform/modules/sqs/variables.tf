#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# Queue
#########################################

variable "queue_name" {
  description = "Amazon SQS Queue Name"
  type        = string
}

#########################################
# FIFO
#########################################

variable "fifo_queue" {
  description = "Enable FIFO Queue"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Enable Content-Based Deduplication"
  type        = bool
  default     = false
}

#########################################
# Queue Configuration
#########################################

variable "delay_seconds" {
  description = "Delay for Messages (Seconds)"
  type        = number
  default     = 0
}

variable "maximum_message_size" {
  description = "Maximum Message Size (Bytes)"
  type        = number
  default     = 262144
}

variable "message_retention_seconds" {
  description = "Message Retention Period (Seconds)"
  type        = number
  default     = 345600
}

variable "visibility_timeout_seconds" {
  description = "Visibility Timeout (Seconds)"
  type        = number
  default     = 30
}

variable "receive_wait_time_seconds" {
  description = "Long Polling Wait Time (Seconds)"
  type        = number
  default     = 20
}

#########################################
# Dead Letter Queue
#########################################

variable "dead_letter_target_arn" {
  description = "Dead Letter Queue ARN"
  type        = string
  default     = null
}

variable "max_receive_count" {
  description = "Maximum Receive Count Before DLQ"
  type        = number
  default     = 5
}

#########################################
# Encryption
#########################################

variable "kms_master_key_id" {
  description = "KMS Key ARN or Alias"
  type        = string
  default     = null
}

variable "kms_data_key_reuse_period_seconds" {
  description = "KMS Data Key Reuse Period (Seconds)"
  type        = number
  default     = 300
}

#########################################
# Queue Policy
#########################################

variable "policy" {
  description = "Queue Policy JSON"
  type        = string
  default     = null
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)
}
