#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# Inspector
#########################################

variable "enable_inspector" {
  description = "Enable Amazon Inspector"
  type        = bool
  default     = true
}

#########################################
# Resource Scanning
#########################################

variable "enable_ec2_scanning" {
  description = "Enable EC2 Scanning"
  type        = bool
  default     = true
}

variable "enable_ecr_scanning" {
  description = "Enable Amazon ECR Scanning"
  type        = bool
  default     = true
}

variable "enable_lambda_scanning" {
  description = "Enable Lambda Scanning"
  type        = bool
  default     = true
}

variable "enable_lambda_code_scanning" {
  description = "Enable Lambda Code Scanning"
  type        = bool
  default     = true
}

#########################################
# Scan Configuration
#########################################

variable "scan_frequency" {
  description = "Inspector Scan Frequency"

  type    = string
  default = "CONTINUOUS"
}

#########################################
# Resource Tags
#########################################

variable "resource_tags" {
  description = "Resource Tags Used for Scanning Scope"
  type        = map(string)
  default     = {}
}

#########################################
# Account Scope
#########################################

variable "account_ids" {
  description = "AWS Account IDs"

  type    = list(string)
  default = []
}

#########################################
# Organization Configuration
#########################################

variable "organization_configuration" {
  description = "Enable Organization Configuration"

  type    = bool
  default = false
}

#########################################
# Auto Enable
#########################################

variable "auto_enable" {
  description = "Automatically Enable Inspector for New Accounts"

  type    = bool
  default = true
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"

  type = map(string)
}
