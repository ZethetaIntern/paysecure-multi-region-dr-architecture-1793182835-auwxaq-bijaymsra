#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# Replication Group
#########################################

variable "replication_group_id" {
  description = "Redis Replication Group ID"
  type        = string
  default     = "paysecure-redis"
}

variable "description" {
  description = "Redis Replication Group Description"
  type        = string
  default     = "PaySecure Global Redis Datastore"
}

#########################################
# Engine
#########################################

variable "engine" {
  description = "Redis Engine"
  type        = string
  default     = "redis"
}

variable "engine_version" {
  description = "Redis Engine Version"
  type        = string
  default     = "7.1"
}

variable "node_type" {
  description = "Redis Node Type"
  type        = string
}

variable "port" {
  description = "Redis Port"
  type        = number
  default     = 6379
}

#########################################
# Cluster
#########################################

variable "num_cache_clusters" {
  description = "Number of Cache Clusters"
  type        = number
  default     = 2
}

variable "automatic_failover_enabled" {
  description = "Enable Automatic Failover"
  type        = bool
  default     = true
}

variable "multi_az_enabled" {
  description = "Enable Multi AZ"
  type        = bool
  default     = true
}

#########################################
# Encryption
#########################################

variable "transit_encryption_enabled" {
  description = "Enable Transit Encryption"
  type        = bool
  default     = true
}

variable "at_rest_encryption_enabled" {
  description = "Enable At Rest Encryption"
  type        = bool
  default     = true
}

variable "kms_key_arn" {
  description = "KMS Key ARN"
  type        = string
}

variable "auth_token" {
  description = "Redis AUTH Token"
  type        = string
  sensitive   = true
}

#########################################
# Networking
#########################################

variable "primary_subnets" {
  description = "Primary Region Private Subnets"
  type        = list(string)
}

variable "dr_subnets" {
  description = "DR Region Private Subnets"
  type        = list(string)
}

variable "primary_security_group_id" {
  description = "Primary Security Group ID"
  type        = string
}

variable "dr_security_group_id" {
  description = "DR Security Group ID"
  type        = string
}

#########################################
# Backup
#########################################

variable "snapshot_retention_limit" {
  description = "Snapshot Retention Days"
  type        = number
  default     = 7
}

variable "snapshot_window" {
  description = "Snapshot Window"
  type        = string
  default     = "02:00-03:00"
}

#########################################
# Maintenance
#########################################

variable "maintenance_window" {
  description = "Maintenance Window"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)
}
