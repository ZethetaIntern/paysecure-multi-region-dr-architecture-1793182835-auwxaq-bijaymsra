#########################################
# SNS Topic
#########################################

resource "aws_sns_topic" "this" {

  name = var.topic_name

  display_name = var.display_name

  kms_master_key_id = var.kms_master_key_id

  fifo_topic = var.fifo_topic

  content_based_deduplication = var.content_based_deduplication

  delivery_policy = var.delivery_policy

  archive_policy = var.archive_policy

  http_success_feedback_role_arn =
    var.http_success_feedback_role_arn

  http_failure_feedback_role_arn =
    var.http_failure_feedback_role_arn

  http_success_feedback_sample_rate =
    var.http_success_feedback_sample_rate

  tags = merge(
    var.tags,
    {
      Name = var.topic_name
    }
  )
}

#########################################
# SNS Subscriptions
#########################################

resource "aws_sns_topic_subscription" "this" {

  for_each = {
    for index, subscription in var.subscriptions :
    index => subscription
  }

  topic_arn = aws_sns_topic.this.arn

  protocol = each.value.protocol

  endpoint = each.value.endpoint

  endpoint_auto_confirms =
    try(each.value.endpoint_auto_confirms, false)

  raw_message_delivery =
    try(each.value.raw_message_delivery, false)

  filter_policy =
    try(each.value.filter_policy, null)

}
