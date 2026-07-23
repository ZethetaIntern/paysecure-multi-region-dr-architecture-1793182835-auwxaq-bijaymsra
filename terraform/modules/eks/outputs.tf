#########################################
# Cluster
#########################################

output "cluster_id" {
  description = "Amazon EKS Cluster ID"
  value       = aws_eks_cluster.this.id
}

output "cluster_name" {
  description = "Amazon EKS Cluster Name"
  value       = aws_eks_cluster.this.name
}

output "cluster_arn" {
  description = "Amazon EKS Cluster ARN"
  value       = aws_eks_cluster.this.arn
}

output "cluster_endpoint" {
  description = "Amazon EKS API Endpoint"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_version" {
  description = "Kubernetes Version"
  value       = aws_eks_cluster.this.version
}

output "cluster_platform_version" {
  description = "Platform Version"
  value       = aws_eks_cluster.this.platform_version
}

#########################################
# Certificate Authority
#########################################

output "cluster_ca_certificate" {
  description = "Cluster Certificate Authority Data"
  value       = aws_eks_cluster.this.certificate_authority[0].data
  sensitive   = true
}

#########################################
# Networking
#########################################

output "cluster_security_group_id" {
  description = "Cluster Security Group ID"
  value       = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}

output "cluster_endpoint_private_access" {
  description = "Private Endpoint Access"
  value       = aws_eks_cluster.this.vpc_config[0].endpoint_private_access
}

output "cluster_endpoint_public_access" {
  description = "Public Endpoint Access"
  value       = aws_eks_cluster.this.vpc_config[0].endpoint_public_access
}

#########################################
# Node Group
#########################################

output "node_group_name" {
  description = "Managed Node Group Name"
  value       = aws_eks_node_group.default.node_group_name
}

output "node_group_arn" {
  description = "Managed Node Group ARN"
  value       = aws_eks_node_group.default.arn
}

output "node_group_status" {
  description = "Managed Node Group Status"
  value       = aws_eks_node_group.default.status
}

#########################################
# IAM
#########################################

output "cluster_role_arn" {
  description = "Cluster IAM Role ARN"
  value       = aws_iam_role.cluster.arn
}

output "node_role_arn" {
  description = "Worker Node IAM Role ARN"
  value       = aws_iam_role.node.arn
}

#########################################
# OIDC Provider
#########################################

output "oidc_provider_arn" {
  description = "OIDC Provider ARN"
  value       = aws_iam_openid_connect_provider.this.arn
}

output "oidc_provider_url" {
  description = "OIDC Provider URL"
  value       = aws_iam_openid_connect_provider.this.url
}

#########################################
# Launch Template
#########################################

output "launch_template_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.node.id
}

output "launch_template_latest_version" {
  description = "Latest Launch Template Version"
  value       = aws_launch_template.node.latest_version
}
