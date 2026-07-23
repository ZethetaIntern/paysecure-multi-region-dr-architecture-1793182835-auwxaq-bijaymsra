#########################################
# Table
#########################################

output "table_id" {
  description = "DynamoDB Table ID"
  value       = aws_dynamodb_table.this.id
}

output "table_name" {
  description = "DynamoDB Table Name"
  value       = aws_dynamodb_table.this.name
}

output "table_arn" {
  description = "DynamoDB Table ARN"
  value       = aws_dynamodb_table.this.arn
}

#########################################
# Streams
#########################################

output "stream_arn" {
  description = "DynamoDB Stream ARN"
  value       = aws_dynamodb_table.this.stream_arn
}

output "stream_label" {
  description = "DynamoDB Stream Label"
  value       = aws_dynamodb_table.this.stream_label
}

output "latest_stream_arn" {
  description = "Latest DynamoDB Stream ARN"
  value       = aws_dynamodb_table.this.stream_arn
}

#########################################
# Replica
#########################################

output "replica_region" {
  description = "Replica AWS Region"
  value       = var.replica_region
}

#########################################
# Table Configuration
#########################################

output "billing_mode" {
  description = "Billing Mode"
  value       = aws_dynamodb_table.this.billing_mode
}

output "hash_key" {
  description = "Partition Key"
  value       = aws_dynamodb_table.this.hash_key
}

output "range_key" {
  description = "Sort Key"
  value       = aws_dynamodb_table.this.range_key
}

#########################################
# Global Secondary Indexes
#########################################

output "global_secondary_indexes" {
  description = "Configured Global Secondary Indexes"

  value = [
    for gsi in aws_dynamodb_table.this.global_secondary_index : {
      name            = gsi.name
      hash_key        = gsi.hash_key
      range_key       = try(gsi.range_key, null)
      projection_type = gsi.projection_type
    }
  ]
}

#########################################
# Recovery
#########################################

output "point_in_time_recovery_enabled" {
  description = "Point-in-Time Recovery Status"
  value       = true
}

#########################################
# Encryption
#########################################

output "server_side_encryption_enabled" {
  description = "Server Side Encryption Status"
  value       = true
}
