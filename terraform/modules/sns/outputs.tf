#########################################
# SNS Topic
#########################################

output "topic_id" {
  description = "SNS Topic ID"
  value       = aws_sns_topic.this.id
}

output "topic_arn" {
  description = "SNS Topic ARN"
  value       = aws_sns_topic.this.arn
}

output "topic_name" {
  description = "SNS Topic Name"
  value       = aws_sns_topic.this.name
}

#########################################
# FIFO Configuration
#########################################

output "fifo_topic" {
  description = "Whether FIFO Topic is Enabled"
  value       = aws_sns_topic.this.fifo_topic
}

#########################################
# Encryption
#########################################

output "kms_master_key_id" {
  description = "KMS Master Key ID"
  value       = aws_sns_topic.this.kms_master_key_id
}

#########################################
# Subscriptions
#########################################

output "subscription_count" {
  description = "Number of SNS Topic Subscriptions"
  value       = length(var.subscriptions)
}

output "subscription_endpoints" {
  description = "Configured Subscription Endpoints"

  value = [
    for subscription in var.subscriptions :
    subscription.endpoint
  ]
}

#########################################
# Feedback Configuration
#########################################

output "feedback_configuration" {
  description = "SNS Feedback Configuration"

  value = {
    success_feedback_role_arn   = var.http_success_feedback_role_arn
    failure_feedback_role_arn   = var.http_failure_feedback_role_arn
    success_feedback_sample_rate = var.http_success_feedback_sample_rate
  }
}

#########################################
# Delivery Policy
#########################################

output "delivery_policy_configured" {
  description = "Whether a Delivery Policy is Configured"
  value       = var.delivery_policy != null
}

#########################################
# Module Summary
#########################################

output "sns_summary" {
  description = "Amazon SNS Module Summary"

  value = {
    topic_name                  = aws_sns_topic.this.name
    topic_arn                   = aws_sns_topic.this.arn
    fifo_topic                  = aws_sns_topic.this.fifo_topic
    kms_master_key_id           = aws_sns_topic.this.kms_master_key_id
    subscription_count          = length(var.subscriptions)
    delivery_policy_configured  = var.delivery_policy != null
    archive_policy_configured   = var.archive_policy != null
    display_name                = var.display_name
  }
}
