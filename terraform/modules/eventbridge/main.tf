#########################################
# CloudWatch Log Group
#########################################

resource "aws_cloudwatch_log_group" "this" {

  name = "/aws/events/${var.rule_name}"

  retention_in_days = var.log_retention_in_days

  tags = merge(
    var.tags,
    {
      Name = "${var.rule_name}-logs"
    }
  )
}

#########################################
# Event Bus
#########################################

resource "aws_cloudwatch_event_bus" "this" {

  name = var.event_bus_name

  tags = merge(
    var.tags,
    {
      Name = var.event_bus_name
    }
  )
}

#########################################
# Event Rule
#########################################

resource "aws_cloudwatch_event_rule" "this" {

  name = var.rule_name

  description = var.description

  event_bus_name = aws_cloudwatch_event_bus.this.name

  event_pattern = var.event_pattern

  schedule_expression = var.schedule_expression

  state = var.state

  tags = merge(
    var.tags,
    {
      Name = var.rule_name
    }
  )
}

#########################################
# Event Targets
#########################################

resource "aws_cloudwatch_event_target" "this" {

  count = length(var.target_arns)

  rule = aws_cloudwatch_event_rule.this.name

  event_bus_name = aws_cloudwatch_event_bus.this.name

  arn = var.target_arns[count.index]

  role_arn = var.target_role_arn

  dynamic "retry_policy" {

    for_each = [1]

    content {

      maximum_event_age_in_seconds = var.maximum_event_age_in_seconds

      maximum_retry_attempts = var.maximum_retry_attempts

    }

  }

  dynamic "dead_letter_config" {

    for_each = var.dead_letter_queue_arn != null ? [1] : []

    content {

      arn = var.dead_letter_queue_arn

    }

  }

}

#########################################
# Event Archive
#########################################

resource "aws_cloudwatch_event_archive" "this" {

  count = var.enable_archive ? 1 : 0

  name = var.archive_name

  event_source_arn = aws_cloudwatch_event_bus.this.arn

  retention_days = var.archive_retention_days

  description = "Managed by Terraform"

}
