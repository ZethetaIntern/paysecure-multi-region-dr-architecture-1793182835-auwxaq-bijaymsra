#########################################
# EKS Cluster Role
#########################################

output "eks_cluster_role_name" {
  description = "EKS Cluster IAM Role Name"
  value       = aws_iam_role.eks_cluster.name
}

output "eks_cluster_role_arn" {
  description = "EKS Cluster IAM Role ARN"
  value       = aws_iam_role.eks_cluster.arn
}

#########################################
# Worker Node Role
#########################################

output "eks_node_role_name" {
  description = "EKS Worker Node IAM Role Name"
  value       = aws_iam_role.eks_node.name
}

output "eks_node_role_arn" {
  description = "EKS Worker Node IAM Role ARN"
  value       = aws_iam_role.eks_node.arn
}

#########################################
# IRSA Role
#########################################

output "irsa_role_name" {
  description = "IRSA IAM Role Name"
  value       = aws_iam_role.irsa.name
}

output "irsa_role_arn" {
  description = "IRSA IAM Role ARN"
  value       = aws_iam_role.irsa.arn
}

#########################################
# Custom Policy
#########################################

output "custom_policy_arn" {
  description = "Custom IAM Policy ARN"

  value = (
    length(aws_iam_policy.custom) > 0
    ? aws_iam_policy.custom[0].arn
    : null
  )
}

#########################################
# OIDC
#########################################

output "oidc_provider_arn" {
  description = "OIDC Provider ARN"
  value       = var.oidc_provider_arn
}

#########################################
# Attached Policies
#########################################

output "cluster_policy_attachments" {
  description = "Attached Cluster Managed Policies"

  value = [
    for attachment in aws_iam_role_policy_attachment.cluster_managed :
    attachment.policy_arn
  ]
}

output "node_policy_attachments" {
  description = "Attached Worker Node Managed Policies"

  value = [
    for attachment in aws_iam_role_policy_attachment.node_managed :
    attachment.policy_arn
  ]
}

#########################################
# Module Summary
#########################################

output "iam_summary" {
  description = "IAM Module Summary"

  value = {
    cluster_role = aws_iam_role.eks_cluster.name
    node_role    = aws_iam_role.eks_node.name
    irsa_role    = aws_iam_role.irsa.name

    cluster_policies = length(
      aws_iam_role_policy_attachment.cluster_managed
    )

    node_policies = length(
      aws_iam_role_policy_attachment.node_managed
    )

    custom_policy_enabled = length(
      aws_iam_policy.custom
    ) > 0
  }
}
