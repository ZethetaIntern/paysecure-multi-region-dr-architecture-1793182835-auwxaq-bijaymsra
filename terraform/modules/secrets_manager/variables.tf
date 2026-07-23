#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# Secret
#########################################

variable "secret_name" {
  description = "AWS Secrets Manager Secret Name"
  type        = string
}

variable "description" {
  description = "Secret Description"
  type        = string
  default     = "Managed by Terraform"
}

variable "secret_string" {
  description = "Secret Value"
  type        = string
  sensitive   = true
}

#########################################
# Encryption
#########################################

variable "kms_key_arn" {
  description = "KMS Key ARN"
  type        = string
}

#########################################
# Recovery
#########################################

variable "recovery_window_in_days" {
  description = "Recovery Window Before Permanent Deletion"
  type        = number
  default     = 30
}

#########################################
# Rotation
#########################################

variable "enable_rotation" {
  description = "Enable Automatic Secret Rotation"
  type        = bool
  default     = false
}

variable "rotation_lambda_arn" {
  description = "Lambda ARN Used for Secret Rotation"
  type        = string
  default     = null
}

variable "rotation_days" {
  description = "Rotation Interval (Days)"
  type        = number
  default     = 30
}

#########################################
# Multi-Region Replication
#########################################

variable "replica_regions" {
  description = "Replica Regions for Multi-Region Secrets"

  type = list(object({
    region     = string
    kms_key_id = optional(string)
  }))

  default = []
}

#########################################
# Secret Tags
#########################################

variable "secret_tags" {
  description = "Tags Applied to the Secret"
  type        = map(string)
  default     = {}
}

#########################################
# Resource Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)
}
