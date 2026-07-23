#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# IAM Role Names
#########################################

variable "eks_cluster_role_name" {
  description = "EKS Cluster IAM Role Name"
  type        = string
  default     = "paysecure-eks-cluster-role"
}

variable "eks_node_role_name" {
  description = "EKS Worker Node IAM Role Name"
  type        = string
  default     = "paysecure-eks-node-role"
}

variable "irsa_role_name" {
  description = "IAM Role for Service Accounts (IRSA)"
  type        = string
  default     = "paysecure-irsa-role"
}

#########################################
# IAM Policy Names
#########################################

variable "cluster_policy_name" {
  description = "Cluster IAM Policy Name"
  type        = string
  default     = "paysecure-cluster-policy"
}

variable "node_policy_name" {
  description = "Node IAM Policy Name"
  type        = string
  default     = "paysecure-node-policy"
}

variable "irsa_policy_name" {
  description = "IRSA Policy Name"
  type        = string
  default     = "paysecure-irsa-policy"
}

#########################################
# OIDC
#########################################

variable "oidc_provider_arn" {
  description = "OIDC Provider ARN"
  type        = string
}

variable "oidc_provider_url" {
  description = "OIDC Provider URL"
  type        = string
}

#########################################
# Kubernetes
#########################################

variable "namespace" {
  description = "Kubernetes Namespace"
  type        = string
  default     = "default"
}

variable "service_account_name" {
  description = "Kubernetes Service Account Name"
  type        = string
}

#########################################
# AWS Managed Policies
#########################################

variable "cluster_managed_policy_arns" {
  description = "Managed Policies for EKS Cluster Role"
  type        = list(string)

  default = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  ]
}

variable "node_managed_policy_arns" {
  description = "Managed Policies for Worker Node Role"
  type        = list(string)

  default = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  ]
}

#########################################
# Custom Policy
#########################################

variable "custom_policy_json" {
  description = "Optional Custom IAM Policy JSON"
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
