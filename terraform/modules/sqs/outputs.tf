#########################################
# SQS Queue
#########################################

output "queue_id" {
  description = "Amazon SQS Queue ID"
  value       = aws_sqs_queue.this.id
}

output "queue_name" {
  description = "Amazon SQS Queue Name"
  value       = aws_sqs_queue.this.name
}

output "queue_arn" {
  description = "Amazon SQS Queue ARN"
  value       = aws_sqs_queue.this.arn
}

output "queue_url" {
  description = "Amazon SQS Queue URL"
  value       = aws_sqs_queue.this.url
}

#########################################
# FIFO Configuration
#########################################

output "fifo_queue" {
  description = "Whether FIFO Queue is Enabled"
  value       = aws_sqs_queue.this.fifo_queue
}

#########################################
# Dead Letter Queue
#########################################

output "dead_letter_queue_configuration" {
  description = "Dead Letter Queue Configuration"

  value = {
    enabled              = var.dead_letter_target_arn != null
    dead_letter_queue_arn = var.dead_letter_target_arn
    max_receive_count    = var.max_receive_count
  }
}

#########################################
# Encryption
#########################################

output "kms_configuration" {
  description = "KMS Encryption Configuration"

  value = {
    kms_master_key_id                 = var.kms_master_key_id
    kms_data_key_reuse_period_seconds = var.kms_data_key_reuse_period_seconds
  }
}

#########################################
# Long Polling
#########################################

output "long_polling_configuration" {
  description = "Long Polling Configuration"

  value = {
    receive_wait_time_seconds = var.receive_wait_time_seconds
  }
}

#########################################
# Queue Policy
#########################################

output "queue_policy_configured" {
  description = "Whether a Queue Policy is Configured"
  value       = var.policy != null
}

#########################################
# Module Summary
#########################################

output "sqs_summary" {
  description = "Amazon SQS Module Summary"

  value = {
    queue_name                    = aws_sqs_queue.this.name
    queue_arn                     = aws_sqs_queue.this.arn
    fifo_queue                    = aws_sqs_queue.this.fifo_queue
    message_retention_seconds      = aws_sqs_queue.this.message_retention_seconds
    visibility_timeout_seconds     = aws_sqs_queue.this.visibility_timeout_seconds
    receive_wait_time_seconds      = aws_sqs_queue.this.receive_wait_time_seconds
    dead_letter_queue_enabled      = var.dead_letter_target_arn != null
    kms_encryption_enabled         = var.kms_master_key_id != null
    queue_policy_configured        = var.policy != null
  }
}
