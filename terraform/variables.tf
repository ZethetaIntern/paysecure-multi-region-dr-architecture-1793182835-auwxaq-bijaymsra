#########################################
# Project Configuration
#########################################

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "paysecure-dr"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"
}

#########################################
# AWS Regions
#########################################

variable "primary_region" {
  description = "Primary AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "dr_region" {
  description = "Disaster Recovery AWS Region"
  type        = string
  default     = "ap-south-2"
}

#########################################
# Availability Zones
#########################################

variable "primary_azs" {
  description = "Availability Zones for Primary Region"
  type        = list(string)

  default = [
    "ap-south-1a",
    "ap-south-1b",
    "ap-south-1c"
  ]
}

variable "dr_azs" {
  description = "Availability Zones for DR Region"
  type        = list(string)

  default = [
    "ap-south-2a",
    "ap-south-2b",
    "ap-south-2c"
  ]
}

#########################################
# VPC
#########################################

variable "primary_vpc_cidr" {
  description = "Primary VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "dr_vpc_cidr" {
  description = "DR VPC CIDR"
  type        = string
  default     = "10.1.0.0/16"
}

#########################################
# Public Subnets
#########################################

variable "primary_public_subnets" {
  type = list(string)

  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
}

variable "dr_public_subnets" {
  type = list(string)

  default = [
    "10.1.1.0/24",
    "10.1.2.0/24",
    "10.1.3.0/24"
  ]
}

#########################################
# Private Application Subnets
#########################################

variable "primary_private_app_subnets" {
  type = list(string)

  default = [
    "10.0.11.0/24",
    "10.0.12.0/24",
    "10.0.13.0/24"
  ]
}

variable "dr_private_app_subnets" {
  type = list(string)

  default = [
    "10.1.11.0/24",
    "10.1.12.0/24",
    "10.1.13.0/24"
  ]
}

#########################################
# Private Database Subnets
#########################################

variable "primary_private_db_subnets" {
  type = list(string)

  default = [
    "10.0.21.0/24",
    "10.0.22.0/24",
    "10.0.23.0/24"
  ]
}

variable "dr_private_db_subnets" {
  type = list(string)

  default = [
    "10.1.21.0/24",
    "10.1.22.0/24",
    "10.1.23.0/24"
  ]
}

#########################################
# Amazon EKS
#########################################

variable "kubernetes_version" {
  description = "Amazon EKS Kubernetes version"
  type        = string
  default     = "1.33"
}

variable "node_instance_type" {
  description = "Worker node instance type"
  type        = string
  default     = "m7g.large"
}

variable "desired_nodes" {
  type    = number
  default = 3
}

variable "min_nodes" {
  type    = number
  default = 3
}

variable "max_nodes" {
  type    = number
  default = 10
}

#########################################
# Aurora
#########################################

variable "aurora_engine_version" {
  type    = string
  default = "16.6"
}

variable "aurora_instance_class" {
  type    = string
  default = "db.r7g.large"
}

#########################################
# Redis
#########################################

variable "redis_node_type" {
  type    = string
  default = "cache.r7g.large"
}

#########################################
# Amazon MSK
#########################################

variable "kafka_instance_type" {
  type    = string
  default = "kafka.m7g.large"
}

variable "kafka_version" {
  type    = string
  default = "3.8.x"
}

#########################################
# Tags
#########################################

variable "common_tags" {

  description = "Common resource tags"

  type = map(string)

  default = {

    Project     = "PaySecure"

    Environment = "Production"

    ManagedBy   = "Terraform"

    Owner       = "Cloud Team"

    CostCenter  = "Payments"

    Repository  = "paysecure-multi-region-dr-architecture"

  }
}
