#########################################
# CloudWatch Log Groups
#########################################

resource "aws_cloudwatch_log_group" "logs" {

  for_each = toset(var.log_group_names)

  name              = each.value
  retention_in_days = var.log_retention_days

  kms_key_id = var.kms_key_arn

  tags = merge(
    var.tags,
    {
      Name = each.value
    }
  )
}

#########################################
# CloudWatch Dashboard
#########################################

resource "aws_cloudwatch_dashboard" "this" {

  dashboard_name = var.dashboard_name

  dashboard_body = jsonencode({

    widgets = [

      {
        "type" : "metric",
        "x" : 0,
        "y" : 0,
        "width" : 12,
        "height" : 6,

        "properties" : {
          "title" : "EC2 CPU Utilization",

          "metrics" : [
            [
              "AWS/EC2",
              "CPUUtilization",
              "InstanceId",
              "*"
            ]
          ],

          "stat" : "Average",
          "period" : 300,
          "region" : data.aws_region.current.name
        }
      },

      {
        "type" : "metric",
        "x" : 12,
        "y" : 0,
        "width" : 12,
        "height" : 6,

        "properties" : {
          "title" : "Network In / Out",

          "metrics" : [
            [
              "AWS/EC2",
              "NetworkIn",
              "InstanceId",
              "*"
            ],
            [
              ".",
              "NetworkOut",
              ".",
              "*"
            ]
          ],

          "stat" : "Average",
          "period" : 300,
          "region" : data.aws_region.current.name
        }
      }

    ]
  })
}

#########################################
# CPU Alarm
#########################################

resource "aws_cloudwatch_metric_alarm" "cpu" {

  alarm_name          = "${var.project_name}-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = var.cpu_threshold

  alarm_description = "CPU utilization exceeded threshold"

  alarm_actions = [
    var.sns_topic_arn
  ]

  ok_actions = [
    var.sns_topic_arn
  ]

  treat_missing_data = "missing"

  tags = var.tags
}

#########################################
# Memory Alarm
#########################################

resource "aws_cloudwatch_metric_alarm" "memory" {

  alarm_name          = "${var.project_name}-memory-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = 300
  statistic           = "Average"
  threshold           = var.memory_threshold

  alarm_description = "Memory utilization exceeded threshold"

  alarm_actions = [
    var.sns_topic_arn
  ]

  ok_actions = [
    var.sns_topic_arn
  ]

  treat_missing_data = "missing"

  tags = var.tags
}

#########################################
# Disk Alarm
#########################################

resource "aws_cloudwatch_metric_alarm" "disk" {

  alarm_name          = "${var.project_name}-disk-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = 300
  statistic           = "Average"
  threshold           = var.disk_threshold

  alarm_description = "Disk utilization exceeded threshold"

  alarm_actions = [
    var.sns_topic_arn
  ]

  ok_actions = [
    var.sns_topic_arn
  ]

  treat_missing_data = "missing"

  tags = var.tags
}

#########################################
# Network Alarm
#########################################

resource "aws_cloudwatch_metric_alarm" "network" {

  alarm_name          = "${var.project_name}-network-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "NetworkIn"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = var.network_threshold

  alarm_description = "Network throughput exceeded threshold"

  alarm_actions = [
    var.sns_topic_arn
  ]

  ok_actions = [
    var.sns_topic_arn
  ]

  treat_missing_data = "missing"

  tags = var.tags
}

#########################################
# Current AWS Region
#########################################

data "aws_region" "current" {}
