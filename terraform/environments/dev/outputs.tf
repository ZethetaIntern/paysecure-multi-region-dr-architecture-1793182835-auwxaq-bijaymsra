#########################################
# Environment
#########################################

output "environment" {
  description = "Deployment Environment"
  value       = local.environment
}

output "aws_region" {
  description = "AWS Region"
  value       = var.aws_region
}

#########################################
# VPC
#########################################

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value       = module.vpc.private_subnet_ids
}

#########################################
# Amazon EKS
#########################################

output "eks_cluster_name" {
  description = "Amazon EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "Amazon EKS Cluster Endpoint"
  value       = module.eks.cluster_endpoint
}

#########################################
# Amazon Aurora
#########################################

output "aurora_cluster_endpoint" {
  description = "Amazon Aurora Cluster Endpoint"
  value       = module.aurora.cluster_endpoint
}

#########################################
# Amazon ElastiCache
#########################################

output "redis_endpoint" {
  description = "Amazon ElastiCache Redis Endpoint"
  value       = module.redis.primary_endpoint
}

#########################################
# Environment Summary
#########################################

output "environment_summary" {
  description = "Development Environment Summary"

  value = {
    environment             = local.environment
    aws_region              = var.aws_region
    vpc_id                  = module.vpc.vpc_id
    public_subnets          = module.vpc.public_subnet_ids
    private_subnets         = module.vpc.private_subnet_ids
    eks_cluster_name        = module.eks.cluster_name
    eks_cluster_endpoint    = module.eks.cluster_endpoint
    aurora_cluster_endpoint = module.aurora.cluster_endpoint
    redis_endpoint          = module.redis.primary_endpoint
  }
}
