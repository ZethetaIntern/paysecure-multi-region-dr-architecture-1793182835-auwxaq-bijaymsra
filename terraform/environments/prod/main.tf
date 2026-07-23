#########################################
# Local Values
#########################################

locals {

  environment = "prod"

  common_tags = merge(
    var.tags,
    {
      Environment = local.environment
      ManagedBy   = "Terraform"
      Project     = var.project_name
    }
  )

}

#########################################
# VPC
#########################################

module "vpc" {

  source = "../../modules/vpc"

  project_name = var.project_name

  environment = local.environment

  vpc_cidr = var.vpc_cidr

  availability_zones = var.availability_zones

  public_subnets = var.public_subnets

  private_subnets = var.private_subnets

  enable_nat_gateway = true

  single_nat_gateway = false

  tags = local.common_tags

}

#########################################
# Security Groups
#########################################

module "security" {

  source = "../../modules/security"

  project_name = var.project_name

  vpc_id = module.vpc.vpc_id

  tags = local.common_tags

}

#########################################
# Amazon EKS
#########################################

module "eks" {

  source = "../../modules/eks"

  project_name = var.project_name

  cluster_name = "${var.project_name}-prod"

  vpc_id = module.vpc.vpc_id

  subnet_ids = module.vpc.private_subnet_ids

  tags = local.common_tags

}

#########################################
# Amazon Aurora
#########################################

module "aurora" {

  source = "../../modules/aurora"

  project_name = var.project_name

  subnet_ids = module.vpc.private_subnet_ids

  security_group_ids = [
    module.security.database_security_group_id
  ]

  tags = local.common_tags

}

#########################################
# Amazon ElastiCache
#########################################

module "redis" {

  source = "../../modules/redis"

  project_name = var.project_name

  subnet_ids = module.vpc.private_subnet_ids

  security_group_ids = [
    module.security.cache_security_group_id
  ]

  tags = local.common_tags

}

#########################################
# Application Load Balancer
#########################################

module "alb" {

  source = "../../modules/alb"

  project_name = var.project_name

  vpc_id = module.vpc.vpc_id

  subnet_ids = module.vpc.public_subnet_ids

  tags = local.common_tags

}

#########################################
# Route53
#########################################

module "route53" {

  source = "../../modules/route53"

  project_name = var.project_name

  tags = local.common_tags

}

#########################################
# AWS WAF
#########################################

module "waf" {

  source = "../../modules/waf"

  project_name = var.project_name

  tags = local.common_tags

}

#########################################
# AWS Certificate Manager
#########################################

module "acm" {

  source = "../../modules/acm"

  project_name = var.project_name

  tags = local.common_tags

}

#########################################
# CloudWatch
#########################################

module "cloudwatch" {

  source = "../../modules/cloudwatch"

  project_name = var.project_name

  tags = local.common_tags

}

#########################################
# GuardDuty
#########################################

module "guardduty" {

  source = "../../modules/guardduty"

  project_name = var.project_name

  tags = local.common_tags

}

#########################################
# Security Hub
#########################################

module "securityhub" {

  source = "../../modules/securityhub"

  project_name = var.project_name

  tags = local.common_tags

}

#########################################
# Amazon Inspector
#########################################

module "inspector" {

  source = "../../modules/inspector"

  project_name = var.project_name

  tags = local.common_tags

}

#########################################
# AWS Backup
#########################################

module "backup" {

  source = "../../modules/backup"

  project_name = var.project_name

  tags = local.common_tags

}
