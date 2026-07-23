#########################################
# Bucket
#########################################

output "bucket_id" {
  description = "S3 Bucket ID"
  value       = aws_s3_bucket.this.id
}

output "bucket_name" {
  description = "S3 Bucket Name"
  value       = aws_s3_bucket.this.bucket
}

output "bucket_arn" {
  description = "S3 Bucket ARN"
  value       = aws_s3_bucket.this.arn
}

#########################################
# Bucket Endpoints
#########################################

output "bucket_domain_name" {
  description = "Bucket Domain Name"
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "Regional Bucket Domain Name"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}

output "hosted_zone_id" {
  description = "Hosted Zone ID"
  value       = aws_s3_bucket.this.hosted_zone_id
}

#########################################
# Versioning
#########################################

output "versioning_status" {
  description = "Bucket Versioning Status"

  value = aws_s3_bucket_versioning.this.versioning_configuration[0].status
}

#########################################
# Encryption
#########################################

output "kms_key_arn" {
  description = "KMS Key ARN"

  value = var.kms_key_arn
}

output "bucket_key_enabled" {
  description = "Bucket Key Status"

  value = var.enable_bucket_key
}

#########################################
# Public Access
#########################################

output "public_access_block" {
  description = "Public Access Block Configuration"

  value = {
    block_public_acls       = var.block_public_acls
    block_public_policy     = var.block_public_policy
    ignore_public_acls      = var.ignore_public_acls
    restrict_public_buckets = var.restrict_public_buckets
  }
}

#########################################
# Replication
#########################################

output "replication_enabled" {
  description = "Cross Region Replication Enabled"

  value = var.replication_enabled
}

#########################################
# Lifecycle
#########################################

output "lifecycle_enabled" {
  description = "Lifecycle Rules Enabled"

  value = var.enable_lifecycle_rules
}

#########################################
# Module Summary
#########################################

output "s3_summary" {
  description = "Amazon S3 Module Summary"

  value = {
    bucket_name          = aws_s3_bucket.this.bucket
    versioning_enabled   = var.versioning_enabled
    object_lock_enabled  = var.object_lock_enabled
    encryption_enabled   = true
    lifecycle_enabled    = var.enable_lifecycle_rules
    replication_enabled  = var.replication_enabled
    access_logs_enabled  = var.access_logging_enabled
    public_access_block  = true
  }
}
