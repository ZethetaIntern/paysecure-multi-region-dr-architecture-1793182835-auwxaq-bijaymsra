#########################################
# CloudWatch Log Group
#########################################

resource "aws_cloudwatch_log_group" "this" {

  name              = var.cloudwatch_log_group_name
  retention_in_days = 30

  kms_key_id = var.kms_key_arn

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-msk-logs"
    }
  )
}

#########################################
# MSK Configuration
#########################################

resource "aws_msk_configuration" "this" {

  name = "${var.cluster_name}-configuration"

  kafka_versions = [
    var.kafka_version
  ]

  server_properties = <<EOF
auto.create.topics.enable=false
default.replication.factor=3
min.insync.replicas=2
num.partitions=6
unclean.leader.election.enable=false
delete.topic.enable=true
log.retention.hours=168
EOF

  description = "Production configuration for ${var.cluster_name}"
}

#########################################
# Amazon MSK Cluster
#########################################

resource "aws_msk_cluster" "this" {

  cluster_name           = var.cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes

  #######################################
  # Broker Nodes
  #######################################

  broker_node_group_info {

    instance_type = var.instance_type

    client_subnets = var.subnet_ids

    security_groups = var.security_group_ids

    storage_info {

      ebs_storage_info {

        volume_size = var.ebs_volume_size

      }

    }

  }

  #######################################
  # Encryption
  #######################################

  encryption_info {

    encryption_at_rest_kms_key_arn = var.kms_key_arn

    encryption_in_transit {

      client_broker = var.client_broker_encryption

      in_cluster = var.in_cluster_encryption

    }

  }

  #######################################
  # Authentication
  #######################################

  client_authentication {

    tls {

      enabled = var.tls_authentication_enabled

    }

    sasl {

      iam = var.iam_authentication_enabled

      scram = var.scram_authentication_enabled

    }

  }

  #######################################
  # Logging
  #######################################

  logging_info {

    broker_logs {

      cloudwatch_logs {

        enabled   = var.cloudwatch_logs_enabled

        log_group = aws_cloudwatch_log_group.this.name

      }

    }

  }

  #######################################
  # Monitoring
  #######################################

  enhanced_monitoring = var.enhanced_monitoring

  #######################################
  # Configuration
  #######################################

  configuration_info {

    arn = aws_msk_configuration.this.arn

    revision = aws_msk_configuration.this.latest_revision

  }

  #######################################
  # Maintenance
  #######################################

  maintenance_window_start_time {

    day_of_week = "SUNDAY"

    time_of_day = "03:00"

    time_zone = "UTC"

  }

  tags = merge(
    var.tags,
    {
      Name    = var.cluster_name
      Service = "Amazon MSK"
    }
  )
}
