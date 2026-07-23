#########################################
# EKS Cluster Trust Policy
#########################################

data "aws_iam_policy_document" "eks_cluster_assume_role" {

  statement {

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

#########################################
# EC2 Trust Policy
#########################################

data "aws_iam_policy_document" "eks_node_assume_role" {

  statement {

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

#########################################
# OIDC Trust Policy (IRSA)
#########################################

data "aws_iam_policy_document" "irsa_assume_role" {

  statement {

    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {

      type = "Federated"

      identifiers = [
        var.oidc_provider_arn
      ]
    }

    condition {

      test = "StringEquals"

      variable = "${replace(var.oidc_provider_url, "https://", "")}:sub"

      values = [
        "system:serviceaccount:${var.namespace}:${var.service_account_name}"
      ]
    }
  }
}

#########################################
# EKS Cluster Role
#########################################

resource "aws_iam_role" "eks_cluster" {

  name = var.eks_cluster_role_name

  assume_role_policy = data.aws_iam_policy_document.eks_cluster_assume_role.json

  tags = merge(
    var.tags,
    {
      Name = var.eks_cluster_role_name
    }
  )
}

#########################################
# Worker Node Role
#########################################

resource "aws_iam_role" "eks_node" {

  name = var.eks_node_role_name

  assume_role_policy = data.aws_iam_policy_document.eks_node_assume_role.json

  tags = merge(
    var.tags,
    {
      Name = var.eks_node_role_name
    }
  )
}

#########################################
# IRSA Role
#########################################

resource "aws_iam_role" "irsa" {

  name = var.irsa_role_name

  assume_role_policy = data.aws_iam_policy_document.irsa_assume_role.json

  tags = merge(
    var.tags,
    {
      Name = var.irsa_role_name
    }
  )
}

#########################################
# Cluster Policy Attachments
#########################################

resource "aws_iam_role_policy_attachment" "cluster_managed" {

  for_each = toset(var.cluster_managed_policy_arns)

  role       = aws_iam_role.eks_cluster.name
  policy_arn = each.value
}

#########################################
# Worker Node Policy Attachments
#########################################

resource "aws_iam_role_policy_attachment" "node_managed" {

  for_each = toset(var.node_managed_policy_arns)

  role       = aws_iam_role.eks_node.name
  policy_arn = each.value
}

#########################################
# Optional Custom Policy
#########################################

resource "aws_iam_policy" "custom" {

  count = var.custom_policy_json == null ? 0 : 1

  name = "${var.project_name}-custom-policy"

  policy = var.custom_policy_json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "custom" {

  count = var.custom_policy_json == null ? 0 : 1

  role = aws_iam_role.irsa.name

  policy_arn = aws_iam_policy.custom[0].arn
}
