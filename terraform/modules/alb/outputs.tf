#########################################
# Application Load Balancer
#########################################

output "alb_arn" {
  description = "Application Load Balancer ARN"
  value       = aws_lb.this.arn
}

output "alb_arn_suffix" {
  description = "Application Load Balancer ARN Suffix"
  value       = aws_lb.this.arn_suffix
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS Name"
  value       = aws_lb.this.dns_name
}

output "alb_hosted_zone_id" {
  description = "Application Load Balancer Hosted Zone ID"
  value       = aws_lb.this.zone_id
}

output "alb_canonical_hosted_zone_id" {
  description = "Canonical Hosted Zone ID"
  value       = aws_lb.this.zone_id
}

#########################################
# Target Group
#########################################

output "target_group_arn" {
  description = "Target Group ARN"
  value       = aws_lb_target_group.this.arn
}

output "target_group_name" {
  description = "Target Group Name"
  value       = aws_lb_target_group.this.name
}

#########################################
# Listeners
#########################################

output "http_listener_arn" {
  description = "HTTP Listener ARN"
  value       = aws_lb_listener.http.arn
}

output "https_listener_arn" {
  description = "HTTPS Listener ARN"
  value       = aws_lb_listener.https.arn
}

#########################################
# Module Summary
#########################################

output "alb_summary" {
  description = "Application Load Balancer Module Summary"

  value = {
    name                  = aws_lb.this.name
    dns_name              = aws_lb.this.dns_name
    target_group          = aws_lb_target_group.this.name
    http_listener_port    = var.http_listener_port
    https_listener_port   = var.https_listener_port
    deletion_protection   = var.enable_deletion_protection
    access_logs_enabled   = var.access_logs_enabled
    health_check_path     = var.health_check_path
    backend_protocol      = var.backend_protocol
    backend_port          = var.backend_port
  }
}
