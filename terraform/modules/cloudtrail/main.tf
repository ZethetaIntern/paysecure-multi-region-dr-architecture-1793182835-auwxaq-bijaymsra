#########################################
# Local Values
#########################################

locals {

  insight_types = compact([
    var.enable_api_call_rate_insight ? "ApiCallRateInsight" : null,
    var.enable_api_error_rate_insight ? "ApiErrorRateInsight" : null
  ])

}

#########################################
# CloudTrail
#########################################

resource "aws_cloudtrail" "this" {

  name = var.trail_name

  s3_bucket_name = var.s3_bucket_name

  kms_key_id = var.kms_key_id

  #######################################
  # CloudWatch Logs
  #######################################

  cloud_watch_logs_group_arn = var.cloudwatch_log_group_arn

  cloud_watch_logs_role_arn = var.cloudwatch_logs_role_arn

  #######################################
  # Trail Configuration
  #######################################

  is_multi_region_trail = var.is_multi_region_trail

  is_organization_trail = var.is_organization_trail

  include_global_service_events =
    var.include_global_service_events

  enable_log_file_validation =
    var.enable_log_file_validation

  #######################################
  # Insight Selectors
  #######################################

  dynamic "insight_selector" {

    for_each = local.insight_types

    content {

      insight_type = insight_selector.value

    }

  }

  #######################################
  # Event Selectors
  #######################################

  event_selector {

    read_write_type = var.read_write_type

    include_management_events =
      var.include_management_events

    dynamic "data_resource" {

      for_each = var.data_resources

      content {

        type = data_resource.value.type

        values = data_resource.value.values

      }

    }

  }

  #######################################
  # Tags
  #######################################

  tags = merge(
    var.tags,
    {
      Name = var.trail_name
    }
  )

}
