#########################################
# Cluster Configuration
#########################################

variable "cluster_name" {
  description = "Amazon EKS Cluster Name"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes Version"
  type        = string
}

#########################################
# Networking
#########################################

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Private Subnet IDs"
  type        = list(string)
}

#########################################
# Worker Nodes
#########################################

variable "instance_type" {
  description = "EC2 Instance Type for Worker Nodes"
  type        = string
}

variable "desired_nodes" {
  description = "Desired Number of Worker Nodes"
  type        = number
}

variable "min_nodes" {
  description = "Minimum Number of Worker Nodes"
  type        = number
}

variable "max_nodes" {
  description = "Maximum Number of Worker Nodes"
  type        = number
}

variable "disk_size" {
  description = "Worker Node Root Volume Size (GB)"
  type        = number
  default     = 50
}

#########################################
# Cluster Endpoint
#########################################

variable "endpoint_private_access" {
  description = "Enable Private API Server Endpoint"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Enable Public API Server Endpoint"
  type        = bool
  default     = true
}

variable "public_access_cidrs" {
  description = "Allowed CIDRs for Public API Access"
  type        = list(string)

  default = [
    "0.0.0.0/0"
  ]
}

#########################################
# Node Group
#########################################

variable "capacity_type" {
  description = "Worker Node Capacity Type"
  type        = string
  default     = "ON_DEMAND"
}

variable "ami_type" {
  description = "EKS Optimized AMI Type"
  type        = string
  default     = "AL2023_ARM_64_STANDARD"
}

#########################################
# Node Labels
#########################################

variable "node_labels" {
  description = "Labels applied to all worker nodes"
  type        = map(string)

  default = {
    workload = "application"
  }
}

#########################################
# Node Taints
#########################################

variable "node_taints" {
  description = "Optional node taints"

  type = list(object({
    key    = string
    value  = string
    effect = string
  }))

  default = []
}

#########################################
# Logging
#########################################

variable "enabled_cluster_log_types" {
  description = "Enabled EKS Control Plane Logs"

  type = list(string)

  default = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]
}

#########################################
# Encryption
#########################################

variable "kms_key_arn" {
  description = "KMS Key ARN used for Kubernetes secrets encryption"
  type        = string
  default     = null
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)
}
