#########################################
# Configuration Recorder
#########################################

output "configuration_recorder_id" {
  description = "AWS Config Configuration Recorder ID"
  value       = aws_config_configuration_recorder.this.id
}

output "configuration_recorder_name" {
  description = "AWS Config Configuration Recorder Name"
  value       = aws_config_configuration_recorder.this.name
}

output "iam_role_arn" {
  description = "IAM Role ARN Used by AWS Config"
  value       = var.iam_role_arn
}

#########################################
# Delivery Channel
#########################################

output "delivery_channel_name" {
  description = "AWS Config Delivery Channel Name"
  value       = aws_config_delivery_channel.this.name
}

output "s3_bucket_name" {
  description = "S3 Bucket Used for AWS Config Snapshots"
  value       = var.s3_bucket_name
}

output "sns_topic_arn" {
  description = "SNS Topic ARN Used for Notifications"
  value       = var.sns_topic_arn
}

#########################################
# Recording Configuration
#########################################

output "recording_configuration" {
  description = "AWS Config Recording Configuration"

  value = {
    all_supported                  = var.all_supported
    include_global_resource_types  = var.include_global_resource_types
    resource_types                 = var.resource_types
    recording_mode                 = var.recording_mode
  }
}

#########################################
# Snapshot Delivery
#########################################

output "snapshot_delivery_configuration" {
  description = "Snapshot Delivery Configuration"

  value = {
    delivery_frequency = var.snapshot_delivery_frequency
  }
}

#########################################
# Recorder Status
#########################################

output "recorder_enabled" {
  description = "Configuration Recorder Status"
  value       = aws_config_configuration_recorder_status.this.is_enabled
}

#########################################
# Module Summary
#########################################

output "config_summary" {
  description = "AWS Config Module Summary"

  value = {
    recorder_name                 = aws_config_configuration_recorder.this.name
    delivery_channel              = aws_config_delivery_channel.this.name
    recorder_enabled              = aws_config_configuration_recorder_status.this.is_enabled
    recording_mode                = var.recording_mode
    all_supported                 = var.all_supported
    include_global_resources      = var.include_global_resource_types
    snapshot_delivery_frequency   = var.snapshot_delivery_frequency
    s3_bucket                     = var.s3_bucket_name
    sns_notifications_enabled     = var.sns_topic_arn != null
  }
}
