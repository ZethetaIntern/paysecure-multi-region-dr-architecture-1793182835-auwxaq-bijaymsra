#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# Security Hub
#########################################

variable "enable_security_hub" {
  description = "Enable AWS Security Hub"
  type        = bool
  default     = true
}

variable "enable_default_standards" {
  description = "Enable Default Security Standards"
  type        = bool
  default     = true
}

#########################################
# Standards
#########################################

variable "standards_subscription_arns" {
  description = "Security Hub Standards Subscription ARNs"
  type        = list(string)
  default     = []
}

#########################################
# Controls
#########################################

variable "auto_enable_controls" {
  description = "Automatically Enable New Security Controls"
  type        = bool
  default     = true
}

variable "control_finding_generator" {
  description = "Control Finding Generator"

  type    = string
  default = "SECURITY_CONTROL"
}

variable "enable_consolidated_control_findings" {
  description = "Enable Consolidated Control Findings"
  type        = bool
  default     = true
}

#########################################
# Organization Configuration
#########################################

variable "organization_configuration" {
  description = "Enable Organization Configuration"
  type        = bool
  default     = false
}

#########################################
# Member Accounts
#########################################

variable "member_account_ids" {
  description = "Security Hub Member Account IDs"
  type        = list(string)
  default     = []
}

#########################################
# Product Integrations
#########################################

variable "product_subscription_arns" {
  description = "Security Hub Product Subscription ARNs"
  type        = list(string)
  default     = []
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)
}
