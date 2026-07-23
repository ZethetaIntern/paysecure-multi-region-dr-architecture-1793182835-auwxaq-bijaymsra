#########################################
# KMS Customer Managed Key
#########################################

resource "aws_kms_key" "this" {

  description             = "KMS key for ${var.project_name}"
  deletion_window_in_days = var.kms_key_deletion_window
  enable_key_rotation     = var.kms_enable_key_rotation

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-kms"
    }
  )
}

resource "aws_kms_alias" "this" {

  name          = "alias/${var.project_name}"
  target_key_id = aws_kms_key.this.key_id
}

#########################################
# Secrets Manager
#########################################

resource "aws_secretsmanager_secret" "db_credentials" {

  name                    = "${var.project_name}/database"
  recovery_window_in_days = var.secret_recovery_window
  kms_key_id              = aws_kms_key.this.arn

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-database-secret"
    }
  )
}

resource "aws_secretsmanager_secret" "redis_credentials" {

  name                    = "${var.project_name}/redis"
  recovery_window_in_days = var.secret_recovery_window
  kms_key_id              = aws_kms_key.this.arn

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-redis-secret"
    }
  )
}

resource "aws_secretsmanager_secret" "application" {

  name                    = "${var.project_name}/application"
  recovery_window_in_days = var.secret_recovery_window
  kms_key_id              = aws_kms_key.this.arn

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-application-secret"
    }
  )
}

#########################################
# IAM Role
#########################################

resource "aws_iam_role" "application" {

  name = "${var.project_name}-application-role"
  path = var.iam_path

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "ec2.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

  tags = var.tags
}

#########################################
# IAM Policy
#########################################

resource "aws_iam_policy" "application" {

  name = "${var.project_name}-application-policy"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Sid = "Secrets"

        Effect = "Allow"

        Action = [

          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"

        ]

        Resource = [
          aws_secretsmanager_secret.db_credentials.arn,
          aws_secretsmanager_secret.redis_credentials.arn,
          aws_secretsmanager_secret.application.arn
        ]

      },

      {

        Sid = "KMS"

        Effect = "Allow"

        Action = [

          "kms:Decrypt",
          "kms:Encrypt",
          "kms:GenerateDataKey"

        ]

        Resource = [
          aws_kms_key.this.arn
        ]

      }

    ]

  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "application" {

  role       = aws_iam_role.application.name
  policy_arn = aws_iam_policy.application.arn
}

#########################################
# CloudWatch Log Group
#########################################

resource "aws_cloudwatch_log_group" "security" {

  name              = "/aws/security/${var.project_name}"
  retention_in_days = var.log_retention_days

  kms_key_id = aws_kms_key.this.arn

  tags = var.tags
}

#########################################
# Application Security Group
#########################################

resource "aws_security_group" "application" {

  name        = "${var.project_name}-application-sg"
  description = "Application Security Group"
  vpc_id      = var.vpc_id

  ingress {

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-application-sg"
    }
  )
}

#########################################
# Database Security Group
#########################################

resource "aws_security_group" "database" {

  name        = "${var.project_name}-database-sg"
  description = "Database Security Group"
  vpc_id      = var.vpc_id

  ingress {

    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"

    security_groups = [
      aws_security_group.application.id
    ]
  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-database-sg"
    }
  )
}

#########################################
# EKS Security Group
#########################################

resource "aws_security_group" "eks" {

  name        = "${var.project_name}-eks-sg"
  description = "Amazon EKS Security Group"
  vpc_id      = var.vpc_id

  ingress {

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-eks-sg"
    }
  )
}
