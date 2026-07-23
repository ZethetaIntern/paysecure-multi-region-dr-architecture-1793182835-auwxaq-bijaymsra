#########################################
# Primary VPC
#########################################

module "primary_vpc" {

  source = "./modules/vpc"

  providers = {
    aws = aws
  }

  name                 = "${var.project_name}-primary"
  region               = var.primary_region

  vpc_cidr             = var.primary_vpc_cidr

  availability_zones   = var.primary_azs

  public_subnets       = var.primary_public_subnets
  private_app_subnets  = var.primary_private_app_subnets
  private_db_subnets   = var.primary_private_db_subnets

  tags = var.common_tags
}

#########################################
# Disaster Recovery VPC
#########################################

module "dr_vpc" {

  source = "./modules/vpc"

  providers = {
    aws = aws.dr
  }

  name                 = "${var.project_name}-dr"
  region               = var.dr_region

  vpc_cidr             = var.dr_vpc_cidr

  availability_zones   = var.dr_azs

  public_subnets       = var.dr_public_subnets
  private_app_subnets  = var.dr_private_app_subnets
  private_db_subnets   = var.dr_private_db_subnets

  tags = var.common_tags
}

#########################################
# Security
#########################################

module "security" {

  source = "./modules/security"

  providers = {
    aws = aws
  }

  project_name = var.project_name
  environment  = var.environment

  tags = var.common_tags
}

#########################################
# Route53
#########################################

module "route53" {

  source = "./modules/route53"

  providers = {
    aws = aws
  }

  project_name = var.project_name

  tags = var.common_tags
}

#########################################
# Primary Amazon EKS
#########################################

module "primary_eks" {

  source = "./modules/eks"

  providers = {
    aws = aws
  }

  cluster_name = "${var.project_name}-primary"

  kubernetes_version = var.kubernetes_version

  vpc_id = module.primary_vpc.vpc_id

  subnet_ids = module.primary_vpc.private_app_subnet_ids

  instance_type = var.node_instance_type

  desired_nodes = var.desired_nodes
  min_nodes     = var.min_nodes
  max_nodes     = var.max_nodes

  tags = var.common_tags
}

#########################################
# Disaster Recovery Amazon EKS
#########################################

module "dr_eks" {

  source = "./modules/eks"

  providers = {
    aws = aws.dr
  }

  cluster_name = "${var.project_name}-dr"

  kubernetes_version = var.kubernetes_version

  vpc_id = module.dr_vpc.vpc_id

  subnet_ids = module.dr_vpc.private_app_subnet_ids

  instance_type = var.node_instance_type

  desired_nodes = var.desired_nodes
  min_nodes     = var.min_nodes
  max_nodes     = var.max_nodes

  tags = var.common_tags
}

#########################################
# Aurora Global Database
#########################################

module "aurora" {

  source = "./modules/aurora"

  providers = {
    aws    = aws
    aws.dr = aws.dr
  }

  project_name = var.project_name

  primary_vpc_id = module.primary_vpc.vpc_id
  dr_vpc_id      = module.dr_vpc.vpc_id

  primary_subnets = module.primary_vpc.private_db_subnet_ids
  dr_subnets      = module.dr_vpc.private_db_subnet_ids

  engine_version = var.aurora_engine_version
  instance_class = var.aurora_instance_class

  kms_key_arn = module.security.kms_key_arn

  tags = var.common_tags
}

#########################################
# DynamoDB Global Tables
#########################################

module "dynamodb" {

  source = "./modules/dynamodb"

  providers = {
    aws    = aws
    aws.dr = aws.dr
  }

  project_name = var.project_name

  tags = var.common_tags
}

#########################################
# Redis Global Datastore
#########################################

module "redis" {

  source = "./modules/redis"

  providers = {
    aws    = aws
    aws.dr = aws.dr
  }

  project_name = var.project_name

  node_type = var.redis_node_type

  primary_subnets = module.primary_vpc.private_db_subnet_ids
  dr_subnets      = module.dr_vpc.private_db_subnet_ids

  tags = var.common_tags
}

#########################################
# Amazon MSK
#########################################

module "msk" {

  source = "./modules/msk"

  providers = {
    aws    = aws
    aws.dr = aws.dr
  }

  project_name = var.project_name

  kafka_version = var.kafka_version

  instance_type = var.kafka_instance_type

  subnet_ids = module.primary_vpc.private_app_subnet_ids

  tags = var.common_tags
}

#########################################
# Monitoring
#########################################

module "monitoring" {

  source = "./modules/monitoring"

  providers = {
    aws = aws
  }

  project_name = var.project_name

  environment = var.environment

  tags = var.common_tags
}
