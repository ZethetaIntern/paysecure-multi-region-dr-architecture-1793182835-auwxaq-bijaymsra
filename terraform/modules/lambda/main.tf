#########################################
# CloudWatch Log Group
#########################################

resource "aws_cloudwatch_log_group" "this" {

  name = "/aws/lambda/${var.function_name}"

  retention_in_days = var.log_retention_in_days

  tags = merge(
    var.tags,
    {
      Name = "${var.function_name}-logs"
    }
  )
}

#########################################
# Lambda Function
#########################################

resource "aws_lambda_function" "this" {

  function_name = var.function_name

  description = var.description

  role = var.role_arn

  runtime = var.runtime

  handler = var.handler

  memory_size = var.memory_size

  timeout = var.timeout

  reserved_concurrent_executions =
    var.reserved_concurrent_executions

  architectures = var.architectures

  #######################################
  # Deployment Package
  #######################################

  s3_bucket = var.s3_bucket

  s3_key = var.s3_key

  source_code_hash = var.source_code_hash

  #######################################
  # Environment Variables
  #######################################

  environment {

    variables = var.environment_variables

  }

  #######################################
  # VPC Configuration
  #######################################

  dynamic "vpc_config" {

    for_each = length(var.subnet_ids) > 0 ? [1] : []

    content {

      subnet_ids = var.subnet_ids

      security_group_ids = var.security_group_ids

    }

  }

  #######################################
  # Lambda Layers
  #######################################

  layers = var.layers

  #######################################
  # AWS X-Ray
  #######################################

  tracing_config {

    mode = var.tracing_mode

  }

  depends_on = [
    aws_cloudwatch_log_group.this
  ]

  tags = merge(
    var.tags,
    {
      Name = var.function_name
    }
  )
}
