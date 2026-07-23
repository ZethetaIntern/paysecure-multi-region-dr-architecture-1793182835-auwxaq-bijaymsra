#########################################
# Local Values
#########################################

locals {

  redrive_policy = var.dead_letter_target_arn != null ? jsonencode({
    deadLetterTargetArn = var.dead_letter_target_arn
    maxReceiveCount     = var.max_receive_count
  }) : null

}

#########################################
# Amazon SQS Queue
#########################################

resource "aws_sqs_queue" "this" {

  name = var.queue_name

  fifo_queue = var.fifo_queue

  content_based_deduplication =
    var.content_based_deduplication

  #######################################
  # Queue Configuration
  #######################################

  delay_seconds = var.delay_seconds

  maximum_message_size =
    var.maximum_message_size

  message_retention_seconds =
    var.message_retention_seconds

  visibility_timeout_seconds =
    var.visibility_timeout_seconds

  receive_wait_time_seconds =
    var.receive_wait_time_seconds

  #######################################
  # Dead Letter Queue
  #######################################

  redrive_policy = local.redrive_policy

  #######################################
  # Encryption
  #######################################

  kms_master_key_id =
    var.kms_master_key_id

  kms_data_key_reuse_period_seconds =
    var.kms_data_key_reuse_period_seconds

  #######################################
  # Queue Policy
  #######################################

  policy = var.policy

  #######################################
  # Tags
  #######################################

  tags = merge(
    var.tags,
    {
      Name = var.queue_name
    }
  )

}
