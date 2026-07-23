#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# Domain
#########################################

variable "domain_name" {
  description = "Primary Domain Name"
  type        = string
}

variable "subject_alternative_names" {
  description = "Subject Alternative Names (SANs)"
  type        = list(string)
  default     = []
}

#########################################
# Route53
#########################################

variable "hosted_zone_id" {
  description = "Route53 Hosted Zone ID"
  type        = string
}

#########################################
# Certificate Validation
#########################################

variable "validation_method" {
  description = "Certificate Validation Method"
  type        = string
  default     = "DNS"
}

variable "certificate_transparency_logging_preference" {
  description = "Certificate Transparency Logging Preference"
  type        = bool
  default     = true
}

#########################################
# Key Algorithm
#########################################

variable "key_algorithm" {
  description = "Certificate Key Algorithm"
  type        = string
  default     = "RSA_2048"
}

#########################################
# DNS Validation
#########################################

variable "create_dns_validation_records" {
  description = "Create Route53 DNS Validation Records"
  type        = bool
  default     = true
}

variable "wait_for_validation" {
  description = "Wait Until Certificate Validation Completes"
  type        = bool
  default     = true
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)
}
