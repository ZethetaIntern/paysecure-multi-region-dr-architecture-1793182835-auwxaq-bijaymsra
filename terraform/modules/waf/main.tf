#########################################
# Allow IP Set
#########################################

resource "aws_wafv2_ip_set" "allow" {

  count = length(var.allowed_ipv4_addresses) > 0 ? 1 : 0

  name               = "${var.project_name}-allow-ipset"
  scope              = var.scope
  ip_address_version = "IPV4"

  addresses = var.allowed_ipv4_addresses

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-allow-ipset"
    }
  )
}

#########################################
# Block IP Set
#########################################

resource "aws_wafv2_ip_set" "block" {

  count = length(var.blocked_ipv4_addresses) > 0 ? 1 : 0

  name               = "${var.project_name}-block-ipset"
  scope              = var.scope
  ip_address_version = "IPV4"

  addresses = var.blocked_ipv4_addresses

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-block-ipset"
    }
  )
}

#########################################
# Web ACL
#########################################

resource "aws_wafv2_web_acl" "this" {

  name  = var.web_acl_name
  scope = var.scope

  dynamic "default_action" {

    for_each = var.default_action == "allow" ? [1] : []

    content {
      allow {}
    }
  }

  dynamic "default_action" {

    for_each = var.default_action == "block" ? [1] : []

    content {
      block {}
    }
  }

  #######################################
  # Rate Limit Rule
  #######################################

  rule {

    name     = "RateLimit"
    priority = 1

    action {
      block {}
    }

    statement {

      rate_based_statement {

        limit              = var.rate_limit
        aggregate_key_type = "IP"

      }

    }

    visibility_config {

      cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled

      metric_name = "${var.metric_name}-rate-limit"

      sampled_requests_enabled = var.sampled_requests_enabled
    }
  }

  #######################################
  # AWS Managed Rule Groups
  #######################################

  dynamic "rule" {

    for_each = var.managed_rule_groups

    content {

      name     = rule.value.name
      priority = rule.value.priority

      override_action {

        none {}

      }

      statement {

        managed_rule_group_statement {

          name        = rule.value.name

          vendor_name = rule.value.vendor_name

        }

      }

      visibility_config {

        cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled

        metric_name = rule.value.name

        sampled_requests_enabled = var.sampled_requests_enabled

      }
    }
  }

  #######################################
  # Visibility
  #######################################

  visibility_config {

    cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled

    metric_name = var.metric_name

    sampled_requests_enabled = var.sampled_requests_enabled

  }

  tags = merge(
    var.tags,
    {
      Name = var.web_acl_name
    }
  )
}
