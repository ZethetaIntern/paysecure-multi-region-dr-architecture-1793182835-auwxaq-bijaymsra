#########################################
# S3 Bucket
#########################################

resource "aws_s3_bucket" "this" {

  bucket = var.bucket_name

  force_destroy = var.force_destroy

  object_lock_enabled = var.object_lock_enabled

  tags = merge(
    var.tags,
    {
      Name = var.bucket_name
    }
  )
}

#########################################
# Versioning
#########################################

resource "aws_s3_bucket_versioning" "this" {

  bucket = aws_s3_bucket.this.id

  versioning_configuration {

    status = var.versioning_enabled ? "Enabled" : "Suspended"

  }
}

#########################################
# Server Side Encryption
#########################################

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {

  bucket = aws_s3_bucket.this.id

  rule {

    apply_server_side_encryption_by_default {

      sse_algorithm = "aws:kms"

      kms_master_key_id = var.kms_key_arn

    }

    bucket_key_enabled = var.enable_bucket_key

  }
}

#########################################
# Public Access Block
#########################################

resource "aws_s3_bucket_public_access_block" "this" {

  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

#########################################
# Lifecycle Configuration
#########################################

resource "aws_s3_bucket_lifecycle_configuration" "this" {

  count = var.enable_lifecycle_rules ? 1 : 0

  bucket = aws_s3_bucket.this.id

  rule {

    id = "default-lifecycle"

    status = "Enabled"

    transition {

      days = var.transition_to_ia_days

      storage_class = "STANDARD_IA"

    }

    transition {

      days = var.transition_to_glacier_days

      storage_class = "GLACIER"

    }

    expiration {

      days = var.expiration_days

    }

    noncurrent_version_expiration {

      noncurrent_days = var.expiration_days

    }

  }
}

#########################################
# Access Logging
#########################################

resource "aws_s3_bucket_logging" "this" {

  count = var.access_logging_enabled ? 1 : 0

  bucket = aws_s3_bucket.this.id

  target_bucket = var.logging_bucket

  target_prefix = var.logging_prefix
}

#########################################
# Bucket Policy
#########################################

resource "aws_s3_bucket_policy" "this" {

  count = var.bucket_policy == null ? 0 : 1

  bucket = aws_s3_bucket.this.id

  policy = var.bucket_policy
}

#########################################
# Cross Region Replication
#########################################

resource "aws_s3_bucket_replication_configuration" "this" {

  count = var.replication_enabled ? 1 : 0

  bucket = aws_s3_bucket.this.id

  role = var.replication_role_arn

  depends_on = [
    aws_s3_bucket_versioning.this
  ]

  rule {

    id = "cross-region-replication"

    status = "Enabled"

    destination {

      bucket = var.destination_bucket_arn

      storage_class = "STANDARD"

    }

  }
}
