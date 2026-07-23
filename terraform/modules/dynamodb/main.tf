#########################################
# DynamoDB Table
#########################################

resource "aws_dynamodb_table" "this" {

  name         = "${var.project_name}-${var.table_name}"
  billing_mode = var.billing_mode

  hash_key  = var.hash_key
  range_key = var.range_key

  #######################################
  # Attributes
  #######################################

  dynamic "attribute" {

    for_each = var.attributes

    content {

      name = attribute.value.name
      type = attribute.value.type

    }
  }

  #######################################
  # Global Secondary Indexes
  #######################################

  dynamic "global_secondary_index" {

    for_each = var.global_secondary_indexes

    content {

      name            = global_secondary_index.value.name
      hash_key        = global_secondary_index.value.hash_key
      range_key       = try(global_secondary_index.value.range_key, null)
      projection_type = global_secondary_index.value.projection_type

    }
  }

  #######################################
  # Streams
  #######################################

  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_view_type

  #######################################
  # TTL
  #######################################

  ttl {

    enabled        = var.ttl_enabled
    attribute_name = var.ttl_attribute_name

  }

  #######################################
  # Point In Time Recovery
  #######################################

  point_in_time_recovery {

    enabled = var.point_in_time_recovery_enabled

  }

  #######################################
  # Encryption
  #######################################

  server_side_encryption {

    enabled     = var.server_side_encryption_enabled
    kms_key_arn = var.kms_key_arn

  }

  #######################################
  # Replica (Global Table)
  #######################################

  replica {

    region_name = var.replica_region

  }

  #######################################
  # Tags
  #######################################

  tags = merge(

    var.tags,

    {

      Name = "${var.project_name}-${var.table_name}"

      Service = "DynamoDB"

      Replication = "GlobalTable"

    }

  )
}
