#########################################
# Secret
#########################################

output "secret_id" {
  description = "AWS Secrets Manager Secret ID"
  value       = aws_secretsmanager_secret.this.id
}

output "secret_arn" {
  description = "AWS Secrets Manager Secret ARN"
  value       = aws_secretsmanager_secret.this.arn
}

output "secret_name" {
  description = "AWS Secrets Manager Secret Name"
  value       = aws_secretsmanager_secret.this.name
}

#########################################
# Secret Version
#########################################

output "secret_version_id" {
  description = "Secret Version ID"
  value       = aws_secretsmanager_secret_version.this.version_id
}

#########################################
# Encryption
#########################################

output "kms_key_arn" {
  description = "KMS Key ARN Used for Encryption"
  value       = var.kms_key_arn
}

#########################################
# Rotation
#########################################

output "rotation_enabled" {
  description = "Secret Rotation Enabled"
  value       = var.enable_rotation
}

output "rotation_interval_days" {
  description = "Secret Rotation Interval (Days)"
  value       = var.rotation_days
}

#########################################
# Replication
#########################################

output "replica_regions" {
  description = "Configured Replica Regions"
  value = [
    for replica in var.replica_regions : replica.region
  ]
}

#########################################
# Recovery
#########################################

output "recovery_window_in_days" {
  description = "Recovery Window Before Permanent Deletion"
  value       = var.recovery_window_in_days
}

#########################################
# Module Summary
#########################################

output "secrets_manager_summary" {
  description = "AWS Secrets Manager Module Summary"

  value = {
    secret_name             = aws_secretsmanager_secret.this.name
    secret_arn              = aws_secretsmanager_secret.this.arn
    rotation_enabled        = var.enable_rotation
    rotation_interval_days  = var.rotation_days
    replica_region_count    = length(var.replica_regions)
    recovery_window_days    = var.recovery_window_in_days
    kms_key_arn             = var.kms_key_arn
  }
}
