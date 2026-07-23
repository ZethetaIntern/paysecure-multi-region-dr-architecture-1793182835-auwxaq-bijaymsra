#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# Lambda Function
#########################################

variable "function_name" {
  description = "Lambda Function Name"
  type        = string
}

variable "description" {
  description = "Lambda Function Description"
  type        = string
  default     = "Managed by Terraform"
}

#########################################
# Runtime
#########################################

variable "runtime" {
  description = "Lambda Runtime"
  type        = string
  default     = "python3.12"
}

variable "handler" {
  description = "Lambda Handler"
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "architectures" {
  description = "Lambda Architectures"
  type        = list(string)
  default     = ["x86_64"]
}

#########################################
# Compute
#########################################

variable "memory_size" {
  description = "Lambda Memory (MB)"
  type        = number
  default     = 512
}

variable "timeout" {
  description = "Lambda Timeout (Seconds)"
  type        = number
  default     = 30
}

variable "reserved_concurrent_executions" {
  description = "Reserved Concurrent Executions"
  type        = number
  default     = -1
}

#########################################
# IAM
#########################################

variable "role_arn" {
  description = "IAM Role ARN"
  type        = string
}

#########################################
# Deployment Package
#########################################

variable "s3_bucket" {
  description = "S3 Bucket Containing Deployment Package"
  type        = string
}

variable "s3_key" {
  description = "S3 Object Key"
  type        = string
}

variable "source_code_hash" {
  description = "Base64 Encoded SHA256 Hash"
  type        = string
  default     = null
}

#########################################
# Environment
#########################################

variable "environment_variables" {
  description = "Lambda Environment Variables"
  type        = map(string)
  default     = {}
}

#########################################
# Networking
#########################################

variable "subnet_ids" {
  description = "Private Subnet IDs"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "Security Group IDs"
  type        = list(string)
  default     = []
}

#########################################
# Layers
#########################################

variable "layers" {
  description = "Lambda Layer ARNs"
  type        = list(string)
  default     = []
}

#########################################
# X-Ray
#########################################

variable "tracing_mode" {
  description = "AWS X-Ray Tracing Mode"
  type        = string
  default     = "Active"
}

#########################################
# CloudWatch Logs
#########################################

variable "log_retention_in_days" {
  description = "CloudWatch Log Retention Period"
  type        = number
  default     = 30
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)
}
