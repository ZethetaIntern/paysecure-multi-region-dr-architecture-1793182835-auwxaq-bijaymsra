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
# Networking
#########################################

output "vpc_id" {
  description = "Production VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Production Public Subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Production Private Subnet IDs"
  value       = module.vpc.private_subnet_ids
}

#########################################
# Amazon EKS
#########################################

output "eks_cluster_name" {
  description = "Production EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "Production EKS Cluster Endpoint"
  value       = module.eks.cluster_endpoint
}

#########################################
# Amazon Aurora
#########################################

output "aurora_cluster_endpoint" {
  description = "Production Aurora Cluster Endpoint"
  value       = module.aurora.cluster_endpoint
}

#########################################
# Amazon ElastiCache
#########################################

output "redis_endpoint" {
  description = "Production Redis Endpoint"
  value       = module.redis.primary_endpoint
}

#########################################
# Application Load Balancer
#########################################

output "alb_dns_name" {
  description = "Application Load Balancer DNS Name"
  value       = module.alb.alb_dns_name
}

#########################################
# Route53
#########################################

output "route53_hosted_zone_id" {
  description = "Route53 Hosted Zone ID"
  value       = module.route53.hosted_zone_id
}

#########################################
# AWS WAF
#########################################

output "waf_web_acl_arn" {
  description = "AWS WAF Web ACL ARN"
  value       = module.waf.web_acl_arn
}

#########################################
# AWS Certificate Manager
#########################################

output "acm_certificate_arn" {
  description = "ACM Certificate ARN"
  value       = module.acm.certificate_arn
}

#########################################
# Production Summary
#########################################

output "environment_summary" {
  description = "Production Environment Summary"

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
    alb_dns_name            = module.alb.alb_dns_name
    hosted_zone_id          = module.route53.hosted_zone_id
    waf_web_acl_arn         = module.waf.web_acl_arn
    acm_certificate_arn     = module.acm.certificate_arn
  }
}
