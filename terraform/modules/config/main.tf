#########################################
# Configuration Recorder
#########################################

resource "aws_config_configuration_recorder" "this" {

  name = var.configuration_recorder_name

  role_arn = var.iam_role_arn

  recording_group {

    all_supported = var.all_supported

    include_global_resource_types =
      var.include_global_resource_types

    resource_types = var.resource_types

  }

  recording_mode {

    recording_frequency = var.recording_mode

  }

}

#########################################
# Delivery Channel
#########################################

resource "aws_config_delivery_channel" "this" {

  name = var.delivery_channel_name

  s3_bucket_name = var.s3_bucket_name

  sns_topic_arn = var.sns_topic_arn

  snapshot_delivery_properties {

    delivery_frequency =
      var.snapshot_delivery_frequency

  }

}

#########################################
# Configuration Recorder Status
#########################################

resource "aws_config_configuration_recorder_status" "this" {

  name = aws_config_configuration_recorder.this.name

  is_enabled = true

  depends_on = [
    aws_config_delivery_channel.this
  ]

}
