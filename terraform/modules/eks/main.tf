#########################################
# IAM Role for EKS Cluster
#########################################

resource "aws_iam_role" "cluster" {

  name = "${var.cluster_name}-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "eks.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "cluster_policy" {

  role       = aws_iam_role.cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

#########################################
# IAM Role for Worker Nodes
#########################################

resource "aws_iam_role" "node" {

  name = "${var.cluster_name}-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "worker_node" {

  role       = aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "cni" {

  role       = aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ecr" {

  role       = aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

#########################################
# Launch Template
#########################################

resource "aws_launch_template" "node" {

  name_prefix = "${var.cluster_name}-"

  update_default_version = true

  block_device_mappings {

    device_name = "/dev/xvda"

    ebs {

      volume_size = var.disk_size
      volume_type = "gp3"
      encrypted   = true

    }
  }

  monitoring {

    enabled = true

  }

  tag_specifications {

    resource_type = "instance"

    tags = merge(
      var.tags,
      {
        Name = "${var.cluster_name}-worker"
      }
    )
  }

  tags = var.tags
}

#########################################
# Amazon EKS Cluster
#########################################

resource "aws_eks_cluster" "this" {

  name     = var.cluster_name
  version  = var.kubernetes_version
  role_arn = aws_iam_role.cluster.arn

  enabled_cluster_log_types = var.enabled_cluster_log_types

  vpc_config {

    subnet_ids              = var.subnet_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = var.public_access_cidrs

  }

  dynamic "encryption_config" {

    for_each = var.kms_key_arn == null ? [] : [1]

    content {

      provider {

        key_arn = var.kms_key_arn

      }

      resources = [
        "secrets"
      ]
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_policy
  ]

  tags = var.tags
}

#########################################
# Managed Node Group
#########################################

resource "aws_eks_node_group" "default" {

  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-default"

  node_role_arn = aws_iam_role.node.arn

  subnet_ids = var.subnet_ids

  ami_type      = var.ami_type
  capacity_type = var.capacity_type

  instance_types = [
    var.instance_type
  ]

  scaling_config {

    desired_size = var.desired_nodes
    min_size     = var.min_nodes
    max_size     = var.max_nodes

  }

  launch_template {

    id      = aws_launch_template.node.id
    version = "$Latest"

  }

  labels = var.node_labels

  dynamic "taint" {

    for_each = var.node_taints

    content {

      key    = taint.value.key
      value  = taint.value.value
      effect = taint.value.effect

    }
  }

  depends_on = [

    aws_iam_role_policy_attachment.worker_node,
    aws_iam_role_policy_attachment.cni,
    aws_iam_role_policy_attachment.ecr

  ]

  tags = var.tags
}

#########################################
# OIDC Provider (IRSA)
#########################################

data "tls_certificate" "eks" {

  url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "this" {

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    data.tls_certificate.eks.certificates[0].sha1_fingerprint
  ]

  url = aws_eks_cluster.this.identity[0].oidc[0].issuer

  tags = var.tags
}
