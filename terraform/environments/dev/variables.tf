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
  description = "VPC CIDR Block"
  type        = string
  default     = "10.10.0.0/16"
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
  description = "Public Subnet CIDRs"

  type = list(string)

  default = [
    "10.10.1.0/24",
    "10.10.2.0/24",
    "10.10.3.0/24"
  ]
}

variable "private_subnets" {
  description = "Private Subnet CIDRs"

  type = list(string)

  default = [
    "10.10.11.0/24",
    "10.10.12.0/24",
    "10.10.13.0/24"
  ]
}

#########################################
# Common Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"

  type = map(string)

  default = {
    Project     = "paysecure"
    Environment = "dev"
    Owner       = "DevOps"
    ManagedBy   = "Terraform"
    CostCenter  = "Engineering"
  }
}

#########################################
# Environment Configuration
#########################################

variable "enable_monitoring" {
  description = "Enable Monitoring Stack"
  type        = bool
  default     = true
}

variable "enable_backup" {
  description = "Enable Automated Backups"
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

#########################################
# Module Overrides
#########################################

variable "eks_node_instance_type" {
  description = "EKS Worker Node Instance Type"
  type        = string
  default     = "t3.medium"
}

variable "eks_node_desired_size" {
  description = "Desired Number of Worker Nodes"
  type        = number
  default     = 2
}

variable "eks_node_min_size" {
  description = "Minimum Worker Nodes"
  type        = number
  default     = 2
}

variable "eks_node_max_size" {
  description = "Maximum Worker Nodes"
  type        = number
  default     = 4
}
