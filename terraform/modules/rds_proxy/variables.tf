#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# Proxy
#########################################

variable "proxy_name" {
  description = "Amazon RDS Proxy Name"
  type        = string
  default     = "paysecure-rds-proxy"
}

variable "engine_family" {
  description = "Database Engine Family"
  type        = string
  default     = "MYSQL"
}

#########################################
# IAM
#########################################

variable "iam_role_arn" {
  description = "IAM Role ARN for RDS Proxy"
  type        = string
}

#########################################
# Networking
#########################################

variable "vpc_subnet_ids" {
  description = "Private VPC Subnet IDs"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security Group IDs"
  type        = list(string)
}

#########################################
# Authentication
#########################################

variable "secret_arn" {
  description = "AWS Secrets Manager Secret ARN"
  type        = string
}

variable "iam_auth" {
  description = "IAM Authentication Mode"
  type        = string
  default     = "REQUIRED"
}

#########################################
# TLS
#########################################

variable "require_tls" {
  description = "Require TLS Connections"
  type        = bool
  default     = true
}

#########################################
# Logging
#########################################

variable "debug_logging" {
  description = "Enable Debug Logging"
  type        = bool
  default     = false
}

#########################################
# Connection Management
#########################################

variable "idle_client_timeout" {
  description = "Idle Client Timeout (seconds)"
  type        = number
  default     = 1800
}

variable "max_connections_percent" {
  description = "Maximum Connections Percent"
  type        = number
  default     = 90
}

variable "max_idle_connections_percent" {
  description = "Maximum Idle Connections Percent"
  type        = number
  default     = 50
}

variable "connection_borrow_timeout" {
  description = "Connection Borrow Timeout (seconds)"
  type        = number
  default     = 120
}

#########################################
# Target Database
#########################################

variable "db_cluster_identifier" {
  description = "Aurora Cluster Identifier"
  type        = string
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)
}
