#########################################
# Hosted Zone
#########################################

output "hosted_zone_id" {
  description = "Route53 Hosted Zone ID"
  value       = aws_route53_zone.this.zone_id
}

output "hosted_zone_arn" {
  description = "Route53 Hosted Zone ARN"
  value       = aws_route53_zone.this.arn
}

output "hosted_zone_name" {
  description = "Hosted Zone Name"
  value       = aws_route53_zone.this.name
}

output "name_servers" {
  description = "Route53 Name Servers"
  value       = aws_route53_zone.this.name_servers
}

#########################################
# Health Check
#########################################

output "health_check_id" {
  description = "Route53 Health Check ID"
  value       = aws_route53_health_check.primary.id
}

#########################################
# DNS Records
#########################################

output "primary_record_fqdn" {
  description = "Primary Route53 Record FQDN"
  value       = aws_route53_record.primary.fqdn
}

output "secondary_record_fqdn" {
  description = "Secondary Route53 Record FQDN"
  value       = aws_route53_record.secondary.fqdn
}

output "application_fqdn" {
  description = "Application Fully Qualified Domain Name"
  value       = "${var.application_subdomain}.${var.hosted_zone_name}"
}

#########################################
# Alias Targets
#########################################

output "primary_alb_dns_name" {
  description = "Primary ALB DNS Name"
  value       = var.primary_alb_dns_name
}

output "dr_alb_dns_name" {
  description = "DR ALB DNS Name"
  value       = var.dr_alb_dns_name
}
