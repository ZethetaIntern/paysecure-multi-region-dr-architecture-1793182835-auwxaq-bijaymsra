#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# Configuration Recorder
#########################################

variable "configuration_recorder_name" {
  description = "AWS Config Configuration Recorder Name"
  type        = string
  default     = "default"
}

#########################################
# Delivery Channel
#########################################

variable "delivery_channel_name" {
  description = "AWS Config Delivery Channel Name"
  type        = string
  default     = "default"
}

#########################################
# Storage
#########################################

variable "s3_bucket_name" {
  description = "S3 Bucket Name for AWS Config Snapshots"
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS Topic ARN for AWS Config Notifications"
  type        = string
  default     = null
}

#########################################
# IAM
#########################################

variable "iam_role_arn" {
  description = "IAM Role ARN for AWS Config"
  type        = string
}

#########################################
# Recording Group
#########################################

variable "all_supported" {
  description = "Record All Supported Resource Types"
  type        = bool
  default     = true
}

variable "include_global_resource_types" {
  description = "Include Global Resource Types"
  type        = bool
  default     = true
}

variable "resource_types" {
  description = "Specific Resource Types to Record"
  type        = list(string)
  default     = []
}

#########################################
# Recording Frequency
#########################################

variable "recording_mode" {
  description = "Recording Mode"
  type        = string
  default     = "CONTINUOUS"
}

#########################################
# Snapshot Delivery
#########################################

variable "snapshot_delivery_frequency" {
  description = "Snapshot Delivery Frequency"
  type        = string
  default     = "TwentyFour_Hours"
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)
}
