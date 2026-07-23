#########################################
# Project
#########################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

#########################################
# Load Balancer
#########################################

variable "alb_name" {
  description = "Application Load Balancer Name"
  type        = string
  default     = "paysecure-alb"
}

variable "internal" {
  description = "Whether the ALB is Internal"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "Load Balancer Type"
  type        = string
  default     = "application"
}

variable "ip_address_type" {
  description = "IP Address Type"
  type        = string
  default     = "ipv4"
}

#########################################
# Networking
#########################################

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Public Subnet IDs"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security Group IDs"
  type        = list(string)
}

#########################################
# Listener Configuration
#########################################

variable "http_listener_port" {
  description = "HTTP Listener Port"
  type        = number
  default     = 80
}

variable "https_listener_port" {
  description = "HTTPS Listener Port"
  type        = number
  default     = 443
}

variable "certificate_arn" {
  description = "ACM Certificate ARN"
  type        = string
}

variable "ssl_policy" {
  description = "SSL Policy"
  type        = string
  default     = "ELBSecurityPolicy-TLS13-1-2-2021-06"
}

#########################################
# Target Group
#########################################

variable "target_group_name" {
  description = "Target Group Name"
  type        = string
  default     = "paysecure-tg"
}

variable "target_type" {
  description = "Target Type"
  type        = string
  default     = "ip"
}

variable "backend_port" {
  description = "Backend Application Port"
  type        = number
  default     = 8080
}

variable "backend_protocol" {
  description = "Backend Protocol"
  type        = string
  default     = "HTTP"
}

#########################################
# Health Check
#########################################

variable "health_check_path" {
  description = "Health Check Path"
  type        = string
  default     = "/actuator/health"
}

variable "health_check_interval" {
  description = "Health Check Interval"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Health Check Timeout"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "Healthy Threshold Count"
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  description = "Unhealthy Threshold Count"
  type        = number
  default     = 3
}

variable "success_codes" {
  description = "Expected HTTP Success Codes"
  type        = string
  default     = "200"
}

#########################################
# ALB Settings
#########################################

variable "idle_timeout" {
  description = "ALB Idle Timeout"
  type        = number
  default     = 60
}

variable "enable_deletion_protection" {
  description = "Enable Deletion Protection"
  type        = bool
  default     = true
}

#########################################
# Access Logs
#########################################

variable "access_logs_enabled" {
  description = "Enable ALB Access Logs"
  type        = bool
  default     = true
}

variable "access_logs_bucket" {
  description = "S3 Bucket for ALB Access Logs"
  type        = string
}

variable "access_logs_prefix" {
  description = "S3 Prefix for ALB Access Logs"
  type        = string
  default     = "alb"
}

#########################################
# Tags
#########################################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)
}
