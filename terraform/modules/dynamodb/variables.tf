#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# Table
#########################################

variable "table_name" {
  description = "DynamoDB Table Name"
  type        = string
  default     = "transactions"
}

variable "billing_mode" {
  description = "Billing Mode"
  type        = string
  default     = "PAY_PER_REQUEST"
}

#########################################
# Primary Keys
#########################################

variable "hash_key" {
  description = "Partition Key"
  type        = string
  default     = "transaction_id"
}

variable "range_key" {
  description = "Sort Key"
  type        = string
  default     = "created_at"
}

#########################################
# Attributes
#########################################

variable "attributes" {

  description = "Table Attributes"

  type = list(object({
    name = string
    type = string
  }))

  default = [
    {
      name = "transaction_id"
      type = "S"
    },
    {
      name = "created_at"
      type = "S"
    },
    {
      name = "customer_id"
      type = "S"
    },
    {
      name = "status"
      type = "S"
    }
  ]
}

#########################################
# Global Secondary Indexes
#########################################

variable "global_secondary_indexes" {

  description = "Global Secondary Indexes"

  type = list(object({

    name            = string
    hash_key        = string
    range_key       = optional(string)
    projection_type = string

  }))

  default = [
    {
      name            = "CustomerIndex"
      hash_key        = "customer_id"
      range_key       = "created_at"
      projection_type = "ALL"
    },
    {
      name            = "StatusIndex"
      hash_key        = "status"
      range_key       = "created_at"
      projection_type = "ALL"
    }
  ]
}

#########################################
# Streams
#########################################

variable "stream_enabled" {
  description = "Enable DynamoDB Streams"
  type        = bool
  default     = true
}

variable "stream_view_type" {
  description = "DynamoDB Stream View Type"
  type        = string
  default     = "NEW_AND_OLD_IMAGES"
}

#########################################
# TTL
#########################################

variable "ttl_enabled" {
  description = "Enable TTL"
  type        = bool
  default     = true
}

variable "ttl_attribute_name" {
  description = "TTL Attribute"
  type        = string
  default     = "expires_at"
}

#########################################
# Backup & Recovery
#########################################

variable "point_in_time_recovery_enabled" {
  description = "Enable Point-in-Time Recovery"
  type        = bool
  default     = true
}

#########################################
# Encryption
#########################################

variable "server_side_encryption_enabled" {
  description = "Enable Server Side Encryption"
  type        = bool
  default     = true
}

variable "kms_key_arn" {
  description = "KMS Key ARN"
  type        = string
}

#########################################
# Replica
#########################################

variable "replica_region" {
  description = "Replica AWS Region"
  type        = string
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)
}
