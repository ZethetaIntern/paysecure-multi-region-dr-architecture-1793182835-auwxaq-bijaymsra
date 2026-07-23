#########################################
# Secrets Manager Secret
#########################################

resource "aws_secretsmanager_secret" "this" {

  name = var.secret_name

  description = var.description

  kms_key_id = var.kms_key_arn

  recovery_window_in_days = var.recovery_window_in_days

  #######################################
  # Multi-Region Replication
  #######################################

  dynamic "replica" {

    for_each = var.replica_regions

    content {

      region = replica.value.region

      kms_key_id = try(replica.value.kms_key_id, null)

    }

  }

  tags = merge(
    var.tags,
    var.secret_tags,
    {
      Name = var.secret_name
    }
  )
}

#########################################
# Secret Version
#########################################

resource "aws_secretsmanager_secret_version" "this" {

  secret_id = aws_secretsmanager_secret.this.id

  secret_string = var.secret_string

}

#########################################
# Secret Rotation
#########################################

resource "aws_secretsmanager_secret_rotation" "this" {

  count = var.enable_rotation ? 1 : 0

  secret_id = aws_secretsmanager_secret.this.id

  rotation_lambda_arn = var.rotation_lambda_arn

  rotation_rules {

    automatically_after_days = var.rotation_days

  }

}
