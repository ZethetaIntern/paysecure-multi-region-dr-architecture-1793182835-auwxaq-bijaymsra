#########################################
# Project
#########################################

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

#########################################
# KMS
#########################################

variable "kms_key_deletion_window" {
  description = "KMS key deletion waiting period"
  type        = number
  default     = 30
}

variable "kms_enable_key_rotation" {
  description = "Enable automatic KMS key rotation"
  type        = bool
  default     = true
}

#########################################
# Secrets Manager
#########################################

variable "secret_recovery_window" {
  description = "Secrets Manager recovery window"
  type        = number
  default     = 30
}

#########################################
# Security Groups
#########################################

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "Allowed CIDR ranges"
  type        = list(string)

  default = [
    "10.0.0.0/8"
  ]
}

#########################################
# IAM
#########################################

variable "iam_path" {
  description = "IAM resource path"
  type        = string
  default     = "/"
}

#########################################
# CloudWatch
#########################################

variable "log_retention_days" {
  description = "CloudWatch log retention period"
  type        = number
  default     = 90
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common tags"
  type        = map(string)
}
