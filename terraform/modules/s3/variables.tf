#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# Bucket
#########################################

variable "bucket_name" {
  description = "S3 Bucket Name"
  type        = string
}

variable "force_destroy" {
  description = "Force Destroy Bucket"
  type        = bool
  default     = false
}

#########################################
# Versioning
#########################################

variable "versioning_enabled" {
  description = "Enable Bucket Versioning"
  type        = bool
  default     = true
}

#########################################
# Object Lock
#########################################

variable "object_lock_enabled" {
  description = "Enable Object Lock"
  type        = bool
  default     = false
}

#########################################
# Lifecycle
#########################################

variable "enable_lifecycle_rules" {
  description = "Enable Lifecycle Rules"
  type        = bool
  default     = true
}

variable "transition_to_ia_days" {
  description = "Transition to Standard-IA"
  type        = number
  default     = 30
}

variable "transition_to_glacier_days" {
  description = "Transition to Glacier"
  type        = number
  default     = 90
}

variable "expiration_days" {
  description = "Object Expiration"
  type        = number
  default     = 365
}

#########################################
# Encryption
#########################################

variable "kms_key_arn" {
  description = "KMS Key ARN"
  type        = string
}

variable "enable_bucket_key" {
  description = "Enable Bucket Key"
  type        = bool
  default     = true
}

#########################################
# Public Access
#########################################

variable "block_public_acls" {
  description = "Block Public ACLs"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Block Public Bucket Policy"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Ignore Public ACLs"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Restrict Public Buckets"
  type        = bool
  default     = true
}

#########################################
# Access Logging
#########################################

variable "access_logging_enabled" {
  description = "Enable Access Logging"
  type        = bool
  default     = true
}

variable "logging_bucket" {
  description = "Target Logging Bucket"
  type        = string
}

variable "logging_prefix" {
  description = "Logging Prefix"
  type        = string
  default     = "logs/"
}

#########################################
# Cross Region Replication
#########################################

variable "replication_enabled" {
  description = "Enable Cross Region Replication"
  type        = bool
  default     = false
}

variable "replication_role_arn" {
  description = "Replication IAM Role ARN"
  type        = string
  default     = null
}

variable "destination_bucket_arn" {
  description = "Destination Bucket ARN"
  type        = string
  default     = null
}

#########################################
# Bucket Policy
#########################################

variable "bucket_policy" {
  description = "Bucket Policy JSON"
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
