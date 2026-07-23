#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# GuardDuty Detector
#########################################

variable "enable_detector" {
  description = "Enable Amazon GuardDuty Detector"
  type        = bool
  default     = true
}

variable "finding_publishing_frequency" {
  description = "Finding Publishing Frequency"
  type        = string
  default     = "FIFTEEN_MINUTES"
}

#########################################
# Protection Features
#########################################

variable "enable_s3_protection" {
  description = "Enable S3 Protection"
  type        = bool
  default     = true
}

variable "enable_kubernetes_protection" {
  description = "Enable Kubernetes Protection"
  type        = bool
  default     = true
}

variable "enable_malware_protection" {
  description = "Enable Malware Protection"
  type        = bool
  default     = true
}

variable "enable_eks_audit_logs" {
  description = "Enable EKS Audit Log Monitoring"
  type        = bool
  default     = true
}

variable "enable_rds_login_events" {
  description = "Enable RDS Login Monitoring"
  type        = bool
  default     = true
}

#########################################
# Publishing Destination
#########################################

variable "enable_publishing_destination" {
  description = "Enable GuardDuty Publishing Destination"
  type        = bool
  default     = false
}

variable "destination_arn" {
  description = "Publishing Destination ARN"
  type        = string
  default     = null
}

variable "kms_key_arn" {
  description = "KMS Key ARN for Publishing Destination"
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
