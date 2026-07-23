#########################################
# Lambda Function
#########################################

output "function_id" {
  description = "AWS Lambda Function ID"
  value       = aws_lambda_function.this.id
}

output "function_name" {
  description = "AWS Lambda Function Name"
  value       = aws_lambda_function.this.function_name
}

output "function_arn" {
  description = "AWS Lambda Function ARN"
  value       = aws_lambda_function.this.arn
}

output "invoke_arn" {
  description = "AWS Lambda Function Invoke ARN"
  value       = aws_lambda_function.this.invoke_arn
}

output "qualified_arn" {
  description = "AWS Lambda Qualified ARN"
  value       = aws_lambda_function.this.qualified_arn
}

output "version" {
  description = "Published Lambda Version"
  value       = aws_lambda_function.this.version
}

#########################################
# CloudWatch Logs
#########################################

output "log_group_name" {
  description = "CloudWatch Log Group Name"
  value       = aws_cloudwatch_log_group.this.name
}

#########################################
# Configuration
#########################################

output "runtime" {
  description = "Lambda Runtime"
  value       = aws_lambda_function.this.runtime
}

output "memory_size" {
  description = "Lambda Memory Size (MB)"
  value       = aws_lambda_function.this.memory_size
}

output "timeout" {
  description = "Lambda Timeout (Seconds)"
  value       = aws_lambda_function.this.timeout
}

output "reserved_concurrent_executions" {
  description = "Reserved Concurrent Executions"
  value       = aws_lambda_function.this.reserved_concurrent_executions
}

#########################################
# Module Summary
#########################################

output "lambda_summary" {
  description = "AWS Lambda Module Summary"

  value = {
    function_name                  = aws_lambda_function.this.function_name
    function_arn                   = aws_lambda_function.this.arn
    runtime                        = aws_lambda_function.this.runtime
    memory_size                    = aws_lambda_function.this.memory_size
    timeout                        = aws_lambda_function.this.timeout
    reserved_concurrent_executions = aws_lambda_function.this.reserved_concurrent_executions
    tracing_mode                   = var.tracing_mode
    log_group                      = aws_cloudwatch_log_group.this.name
  }
}
