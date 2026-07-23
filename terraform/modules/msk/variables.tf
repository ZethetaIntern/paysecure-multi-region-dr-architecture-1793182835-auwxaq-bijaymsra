#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "cluster_name" {
  description = "Amazon MSK Cluster Name"
  type        = string
  default     = "paysecure-msk"
}

#########################################
# Kafka
#########################################

variable "kafka_version" {
  description = "Kafka Version"
  type        = string
}

variable "instance_type" {
  description = "Broker Instance Type"
  type        = string
}

variable "number_of_broker_nodes" {
  description = "Number of Kafka Broker Nodes"
  type        = number
  default     = 3
}

#########################################
# Storage
#########################################

variable "ebs_volume_size" {
  description = "Broker EBS Volume Size (GB)"
  type        = number
  default     = 200
}

#########################################
# Networking
#########################################

variable "subnet_ids" {
  description = "Private Subnet IDs"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Broker Security Group IDs"
  type        = list(string)
}

#########################################
# Encryption
#########################################

variable "kms_key_arn" {
  description = "KMS Key ARN"
  type        = string
}

variable "client_broker_encryption" {
  description = "Client Broker Encryption"
  type        = string
  default     = "TLS"
}

variable "in_cluster_encryption" {
  description = "Enable In-Cluster Encryption"
  type        = bool
  default     = true
}

#########################################
# Authentication
#########################################

variable "tls_authentication_enabled" {
  description = "Enable TLS Client Authentication"
  type        = bool
  default     = true
}

variable "iam_authentication_enabled" {
  description = "Enable IAM Authentication"
  type        = bool
  default     = true
}

variable "scram_authentication_enabled" {
  description = "Enable SCRAM Authentication"
  type        = bool
  default     = false
}

#########################################
# Monitoring
#########################################

variable "enhanced_monitoring" {
  description = "Enhanced Monitoring Level"
  type        = string
  default     = "PER_BROKER"
}

variable "cloudwatch_logs_enabled" {
  description = "Enable CloudWatch Logging"
  type        = bool
  default     = true
}

variable "cloudwatch_log_group_name" {
  description = "CloudWatch Log Group Name"
  type        = string
  default     = "/aws/msk/paysecure"
}

#########################################
# Maintenance
#########################################

variable "maintenance_window" {
  description = "Maintenance Window"
  type        = string
  default     = "SUN:03:00-SUN:04:00"
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)
}
