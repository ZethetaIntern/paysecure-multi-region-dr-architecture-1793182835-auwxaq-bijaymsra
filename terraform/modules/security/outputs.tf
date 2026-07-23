#########################################
# KMS
#########################################

output "kms_key_id" {
  description = "KMS Key ID"
  value       = aws_kms_key.this.key_id
}

output "kms_key_arn" {
  description = "KMS Key ARN"
  value       = aws_kms_key.this.arn
}

output "kms_alias" {
  description = "KMS Alias"
  value       = aws_kms_alias.this.name
}

#########################################
# Secrets Manager
#########################################

output "database_secret_arn" {
  description = "Database Secret ARN"
  value       = aws_secretsmanager_secret.db_credentials.arn
}

output "redis_secret_arn" {
  description = "Redis Secret ARN"
  value       = aws_secretsmanager_secret.redis_credentials.arn
}

output "application_secret_arn" {
  description = "Application Secret ARN"
  value       = aws_secretsmanager_secret.application.arn
}

output "secrets_prefix" {
  description = "Secrets Manager Prefix"
  value       = "${var.project_name}/"
}

#########################################
# IAM
#########################################

output "application_role_name" {
  description = "Application IAM Role Name"
  value       = aws_iam_role.application.name
}

output "application_role_arn" {
  description = "Application IAM Role ARN"
  value       = aws_iam_role.application.arn
}

output "application_policy_arn" {
  description = "Application IAM Policy ARN"
  value       = aws_iam_policy.application.arn
}

#########################################
# CloudWatch
#########################################

output "security_log_group_name" {
  description = "Security CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.security.name
}

output "security_log_group_arn" {
  description = "Security CloudWatch Log Group ARN"
  value       = aws_cloudwatch_log_group.security.arn
}

#########################################
# Security Groups
#########################################

output "application_security_group_id" {
  description = "Application Security Group ID"
  value       = aws_security_group.application.id
}

output "application_security_group_arn" {
  description = "Application Security Group ARN"
  value       = aws_security_group.application.arn
}

output "database_security_group_id" {
  description = "Database Security Group ID"
  value       = aws_security_group.database.id
}

output "database_security_group_arn" {
  description = "Database Security Group ARN"
  value       = aws_security_group.database.arn
}

output "eks_security_group_id" {
  description = "Amazon EKS Security Group ID"
  value       = aws_security_group.eks.id
}

output "eks_security_group_arn" {
  description = "Amazon EKS Security Group ARN"
  value       = aws_security_group.eks.arn
}
