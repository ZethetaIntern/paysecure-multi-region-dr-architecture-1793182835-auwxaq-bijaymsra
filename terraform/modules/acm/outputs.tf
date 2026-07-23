#########################################
# Certificate
#########################################

output "certificate_arn" {
  description = "ACM Certificate ARN"
  value       = aws_acm_certificate.this.arn
}

output "certificate_domain_name" {
  description = "Primary Domain Name"
  value       = aws_acm_certificate.this.domain_name
}

output "certificate_status" {
  description = "Certificate Status"
  value       = aws_acm_certificate.this.status
}

output "certificate_type" {
  description = "Certificate Type"
  value       = aws_acm_certificate.this.type
}

#########################################
# Validation
#########################################

output "validation_method" {
  description = "Certificate Validation Method"
  value       = aws_acm_certificate.this.validation_method
}

output "validation_record_fqdns" {
  description = "DNS Validation Record FQDNs"

  value = [
    for record in aws_route53_record.validation :
    record.fqdn
  ]
}

output "certificate_validation_id" {
  description = "Certificate Validation Resource ID"

  value = (
    length(aws_acm_certificate_validation.this) > 0
    ? aws_acm_certificate_validation.this[0].id
    : null
  )
}

#########################################
# Configuration
#########################################

output "key_algorithm" {
  description = "Certificate Key Algorithm"
  value       = aws_acm_certificate.this.key_algorithm
}

output "subject_alternative_names" {
  description = "Subject Alternative Names"

  value = aws_acm_certificate.this.subject_alternative_names
}

output "certificate_transparency_logging" {
  description = "Certificate Transparency Logging Status"

  value = aws_acm_certificate.this.options[0].certificate_transparency_logging_preference
}

#########################################
# Module Summary
#########################################

output "acm_summary" {
  description = "ACM Module Summary"

  value = {
    domain_name              = aws_acm_certificate.this.domain_name
    status                   = aws_acm_certificate.this.status
    validation_method        = aws_acm_certificate.this.validation_method
    key_algorithm            = aws_acm_certificate.this.key_algorithm
    san_count                = length(aws_acm_certificate.this.subject_alternative_names)
    dns_validation_records   = length(aws_route53_record.validation)
    transparency_logging     = aws_acm_certificate.this.options[0].certificate_transparency_logging_preference
  }
}
