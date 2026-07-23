#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# Networking
#########################################

variable "primary_vpc_id" {
  description = "Primary Region VPC ID"
  type        = string
}

variable "dr_vpc_id" {
  description = "DR Region VPC ID"
  type        = string
}

variable "primary_subnets" {
  description = "Primary Database Subnet IDs"
  type        = list(string)
}

variable "dr_subnets" {
  description = "DR Database Subnet IDs"
  type        = list(string)
}

variable "primary_security_group_id" {
  description = "Primary Database Security Group"
  type        = string
}

variable "dr_security_group_id" {
  description = "DR Database Security Group"
  type        = string
}

#########################################
# Database
#########################################

variable "database_name" {
  description = "Initial Database Name"
  type        = string
  default     = "paysecure"
}

variable "master_username" {
  description = "Database Administrator Username"
  type        = string
  default     = "dbadmin"
}

variable "master_password" {
  description = "Database Administrator Password"
  type        = string
  sensitive   = true
}

variable "engine" {
  description = "Aurora Database Engine"
  type        = string
  default     = "aurora-postgresql"
}

variable "engine_version" {
  description = "Aurora Engine Version"
  type        = string
}

variable "instance_class" {
  description = "Aurora Instance Class"
  type        = string
}

#########################################
# Cluster Configuration
#########################################

variable "backup_retention_period" {
  description = "Backup Retention Period"
  type        = number
  default     = 35
}

variable "preferred_backup_window" {
  description = "Backup Window"
  type        = string
  default     = "02:00-03:00"
}

variable "preferred_maintenance_window" {
  description = "Maintenance Window"
  type        = string
  default     = "sun:03:00-sun:04:00"
}

variable "deletion_protection" {
  description = "Enable Deletion Protection"
  type        = bool
  default     = true
}

variable "storage_encrypted" {
  description = "Enable Storage Encryption"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Apply Changes Immediately"
  type        = bool
  default     = false
}

#########################################
# Monitoring
#########################################

variable "performance_insights_enabled" {
  description = "Enable Performance Insights"
  type        = bool
  default     = true
}

variable "monitoring_interval" {
  description = "Enhanced Monitoring Interval"
  type        = number
  default     = 60
}

variable "enabled_cloudwatch_logs_exports" {
  description = "CloudWatch Logs Export"
  type        = list(string)

  default = [
    "postgresql"
  ]
}

#########################################
# Encryption
#########################################

variable "kms_key_arn" {
  description = "KMS Key ARN"
  type        = string
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)
}
