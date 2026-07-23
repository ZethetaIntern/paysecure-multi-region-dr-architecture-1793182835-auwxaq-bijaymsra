#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
  default     = "paysecure"
}

#########################################
# AWS
#########################################

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

#########################################
# Networking
#########################################

variable "vpc_cidr" {
  description = "Production VPC CIDR"
  type        = string
  default     = "10.20.0.0/16"
}

variable "availability_zones" {
  description = "Availability Zones"

  type = list(string)

  default = [
    "ap-south-1a",
    "ap-south-1b",
    "ap-south-1c"
  ]
}

variable "public_subnets" {
  description = "Production Public Subnets"

  type = list(string)

  default = [
    "10.20.1.0/24",
    "10.20.2.0/24",
    "10.20.3.0/24"
  ]
}

variable "private_subnets" {
  description = "Production Private Subnets"

  type = list(string)

  default = [
    "10.20.11.0/24",
    "10.20.12.0/24",
    "10.20.13.0/24"
  ]
}

#########################################
# Production Features
#########################################

variable "enable_monitoring" {
  description = "Enable CloudWatch Monitoring"
  type        = bool
  default     = true
}

variable "enable_backup" {
  description = "Enable AWS Backup"
  type        = bool
  default     = true
}

variable "enable_waf" {
  description = "Enable AWS WAF"
  type        = bool
  default     = true
}

variable "enable_guardduty" {
  description = "Enable Amazon GuardDuty"
  type        = bool
  default     = true
}

variable "enable_securityhub" {
  description = "Enable AWS Security Hub"
  type        = bool
  default     = true
}

variable "enable_inspector" {
  description = "Enable Amazon Inspector"
  type        = bool
  default     = true
}

#########################################
# EKS Configuration
#########################################

variable "eks_node_instance_type" {
  description = "Production EKS Worker Instance Type"
  type        = string
  default     = "m5.large"
}

variable "eks_node_desired_size" {
  description = "Desired Worker Nodes"
  type        = number
  default     = 3
}

variable "eks_node_min_size" {
  description = "Minimum Worker Nodes"
  type        = number
  default     = 3
}

variable "eks_node_max_size" {
  description = "Maximum Worker Nodes"
  type        = number
  default     = 10
}

#########################################
# Common Tags
#########################################

variable "tags" {
  description = "Production Resource Tags"

  type = map(string)

  default = {
    Project     = "paysecure"
    Environment = "prod"
    Owner       = "Platform-Team"
    ManagedBy   = "Terraform"
    CostCenter  = "Production"
    Criticality = "Mission-Critical"
  }
}
