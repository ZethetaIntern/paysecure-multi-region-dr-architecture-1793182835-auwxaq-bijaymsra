#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# Web ACL
#########################################

variable "web_acl_name" {
  description = "AWS WAF Web ACL Name"
  type        = string
  default     = "paysecure-waf"
}

variable "scope" {
  description = "WAF Scope (REGIONAL or CLOUDFRONT)"
  type        = string
  default     = "REGIONAL"
}

#########################################
# Default Action
#########################################

variable "default_action" {
  description = "Default Action (allow or block)"
  type        = string
  default     = "allow"

  validation {
    condition     = contains(["allow", "block"], var.default_action)
    error_message = "default_action must be either 'allow' or 'block'."
  }
}

#########################################
# Rate Limiting
#########################################

variable "rate_limit" {
  description = "Maximum requests allowed within five minutes"
  type        = number
  default     = 2000
}

#########################################
# IP Sets
#########################################

variable "allowed_ipv4_addresses" {
  description = "Allowed IPv4 CIDR Blocks"
  type        = list(string)
  default     = []
}

variable "blocked_ipv4_addresses" {
  description = "Blocked IPv4 CIDR Blocks"
  type        = list(string)
  default     = []
}

#########################################
# AWS Managed Rules
#########################################

variable "managed_rule_groups" {
  description = "AWS Managed Rule Groups"

  type = list(object({
    name        = string
    vendor_name = string
    priority    = number
  }))

  default = [
    {
      name        = "AWSManagedRulesCommonRuleSet"
      vendor_name = "AWS"
      priority    = 10
    },
    {
      name        = "AWSManagedRulesKnownBadInputsRuleSet"
      vendor_name = "AWS"
      priority    = 20
    },
    {
      name        = "AWSManagedRulesSQLiRuleSet"
      vendor_name = "AWS"
      priority    = 30
    }
  ]
}

#########################################
# Visibility
#########################################

variable "cloudwatch_metrics_enabled" {
  description = "Enable CloudWatch Metrics"
  type        = bool
  default     = true
}

variable "sampled_requests_enabled" {
  description = "Enable Sampled Requests"
  type        = bool
  default     = true
}

variable "metric_name" {
  description = "CloudWatch Metric Name"
  type        = string
  default     = "paysecure-waf"
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)
}
