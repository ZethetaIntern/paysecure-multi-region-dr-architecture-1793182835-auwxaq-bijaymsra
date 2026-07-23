#########################################
# Project
#########################################

variable "project_name" {
  description = "Project name"
  type        = string
}

#########################################
# Domain Configuration
#########################################

variable "hosted_zone_name" {
  description = "Route53 Hosted Zone Name"
  type        = string
  default     = "paysecure.com"
}

variable "application_subdomain" {
  description = "Application Subdomain"
  type        = string
  default     = "api"
}

#########################################
# Load Balancers
#########################################

variable "primary_alb_dns_name" {
  description = "Primary Region ALB DNS Name"
  type        = string
}

variable "primary_alb_zone_id" {
  description = "Primary Region ALB Hosted Zone ID"
  type        = string
}

variable "dr_alb_dns_name" {
  description = "DR Region ALB DNS Name"
  type        = string
}

variable "dr_alb_zone_id" {
  description = "DR Region ALB Hosted Zone ID"
  type        = string
}

#########################################
# Route53 Health Check
#########################################

variable "health_check_path" {
  description = "Application Health Check Path"
  type        = string
  default     = "/health"
}

variable "health_check_port" {
  description = "Application Health Check Port"
  type        = number
  default     = 443
}

variable "health_check_protocol" {
  description = "Health Check Protocol"
  type        = string
  default     = "HTTPS"
}

variable "failure_threshold" {
  description = "Health Check Failure Threshold"
  type        = number
  default     = 3
}

variable "request_interval" {
  description = "Health Check Request Interval"
  type        = number
  default     = 30
}

#########################################
# DNS
#########################################

variable "ttl" {
  description = "DNS Record TTL"
  type        = number
  default     = 60
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)
}
