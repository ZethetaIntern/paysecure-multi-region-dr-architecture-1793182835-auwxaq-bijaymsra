#########################################
# Primary VPC
#########################################

output "primary_vpc_id" {
  description = "Primary Region VPC ID"
  value       = module.primary_vpc.vpc_id
}

output "primary_public_subnet_ids" {
  description = "Primary Public Subnet IDs"
  value       = module.primary_vpc.public_subnet_ids
}

output "primary_private_app_subnet_ids" {
  description = "Primary Private Application Subnet IDs"
  value       = module.primary_vpc.private_app_subnet_ids
}

output "primary_private_db_subnet_ids" {
  description = "Primary Private Database Subnet IDs"
  value       = module.primary_vpc.private_db_subnet_ids
}

#########################################
# Disaster Recovery VPC
#########################################

output "dr_vpc_id" {
  description = "DR Region VPC ID"
  value       = module.dr_vpc.vpc_id
}

output "dr_public_subnet_ids" {
  description = "DR Public Subnet IDs"
  value       = module.dr_vpc.public_subnet_ids
}

output "dr_private_app_subnet_ids" {
  description = "DR Private Application Subnet IDs"
  value       = module.dr_vpc.private_app_subnet_ids
}

output "dr_private_db_subnet_ids" {
  description = "DR Private Database Subnet IDs"
  value       = module.dr_vpc.private_db_subnet_ids
}

#########################################
# Primary Amazon EKS
#########################################

output "primary_eks_cluster_name" {
  description = "Primary EKS Cluster Name"
  value       = module.primary_eks.cluster_name
}

output "primary_eks_cluster_endpoint" {
  description = "Primary EKS Cluster Endpoint"
  value       = module.primary_eks.cluster_endpoint
}

output "primary_eks_cluster_arn" {
  description = "Primary EKS Cluster ARN"
  value       = module.primary_eks.cluster_arn
}

output "primary_eks_oidc_provider_arn" {
  description = "OIDC Provider ARN"
  value       = module.primary_eks.oidc_provider_arn
}

#########################################
# Disaster Recovery Amazon EKS
#########################################

output "dr_eks_cluster_name" {
  description = "DR EKS Cluster Name"
  value       = module.dr_eks.cluster_name
}

output "dr_eks_cluster_endpoint" {
  description = "DR EKS Cluster Endpoint"
  value       = module.dr_eks.cluster_endpoint
}

output "dr_eks_cluster_arn" {
  description = "DR EKS Cluster ARN"
  value       = module.dr_eks.cluster_arn
}

#########################################
# Aurora Global Database
#########################################

output "aurora_global_cluster_id" {
  description = "Aurora Global Database ID"
  value       = module.aurora.global_cluster_id
}

output "aurora_primary_endpoint" {
  description = "Primary Aurora Endpoint"
  value       = module.aurora.primary_endpoint
}

output "aurora_reader_endpoint" {
  description = "Aurora Reader Endpoint"
  value       = module.aurora.reader_endpoint
}

#########################################
# Redis
#########################################

output "redis_primary_endpoint" {
  description = "Primary Redis Endpoint"
  value       = module.redis.primary_endpoint
}

output "redis_reader_endpoint" {
  description = "Redis Reader Endpoint"
  value       = module.redis.reader_endpoint
}

#########################################
# Amazon MSK
#########################################

output "msk_cluster_arn" {
  description = "Amazon MSK Cluster ARN"
  value       = module.msk.cluster_arn
}

output "msk_bootstrap_brokers" {
  description = "MSK Bootstrap Brokers"
  value       = module.msk.bootstrap_brokers
}

#########################################
# Load Balancer
#########################################

output "primary_alb_dns_name" {
  description = "Primary ALB DNS Name"
  value       = module.alb_primary.alb_dns_name
}

output "dr_alb_dns_name" {
  description = "DR ALB DNS Name"
  value       = module.alb_dr.alb_dns_name
}

#########################################
# Route53
#########################################

output "route53_hosted_zone_id" {
  description = "Route53 Hosted Zone ID"
  value       = module.route53.hosted_zone_id
}

output "application_fqdn" {
  description = "Application DNS Name"
  value       = module.route53.application_fqdn
}

#########################################
# Security
#########################################

output "kms_key_arn" {
  description = "AWS KMS Key ARN"
  value       = module.security.kms_key_arn
}

output "secrets_manager_prefix" {
  description = "Secrets Manager Prefix"
  value       = module.security.secrets_prefix
}

#########################################
# Monitoring
#########################################

output "cloudwatch_log_group" {
  description = "CloudWatch Log Group"
  value       = module.monitoring.cloudwatch_log_group
}

output "sns_alert_topic_arn" {
  description = "SNS Alert Topic ARN"
  value       = module.monitoring.sns_topic_arn
}
