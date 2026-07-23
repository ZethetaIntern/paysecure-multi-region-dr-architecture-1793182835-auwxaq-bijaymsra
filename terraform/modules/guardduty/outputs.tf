#########################################
# GuardDuty Detector
#########################################

output "detector_id" {
  description = "Amazon GuardDuty Detector ID"
  value       = aws_guardduty_detector.this.id
}

output "detector_arn" {
  description = "Amazon GuardDuty Detector ARN"
  value       = aws_guardduty_detector.this.arn
}

output "detector_enabled" {
  description = "Whether GuardDuty Detector is Enabled"
  value       = aws_guardduty_detector.this.enable
}

output "finding_publishing_frequency" {
  description = "GuardDuty Finding Publishing Frequency"
  value       = aws_guardduty_detector.this.finding_publishing_frequency
}

#########################################
# Protection Features
#########################################

output "s3_protection_enabled" {
  description = "S3 Protection Status"
  value       = var.enable_s3_protection
}

output "kubernetes_protection_enabled" {
  description = "Kubernetes Protection Status"
  value       = var.enable_kubernetes_protection
}

output "malware_protection_enabled" {
  description = "Malware Protection Status"
  value       = var.enable_malware_protection
}

output "eks_audit_logs_enabled" {
  description = "EKS Audit Log Monitoring Status"
  value       = var.enable_eks_audit_logs
}

output "rds_login_events_enabled" {
  description = "RDS Login Event Monitoring Status"
  value       = var.enable_rds_login_events
}

#########################################
# Publishing Destination
#########################################

output "publishing_destination_arn" {
  description = "GuardDuty Publishing Destination ARN"
  value = var.enable_publishing_destination ? aws_guardduty_publishing_destination.this[0].destination_arn : null
}

output "kms_key_arn" {
  description = "KMS Key ARN Used for Publishing Destination"
  value       = var.kms_key_arn
}

#########################################
# Module Summary
#########################################

output "guardduty_summary" {
  description = "Amazon GuardDuty Module Summary"

  value = {
    detector_id                  = aws_guardduty_detector.this.id
    detector_arn                 = aws_guardduty_detector.this.arn
    detector_enabled             = aws_guardduty_detector.this.enable
    finding_frequency            = aws_guardduty_detector.this.finding_publishing_frequency
    s3_protection                = var.enable_s3_protection
    kubernetes_protection        = var.enable_kubernetes_protection
    malware_protection           = var.enable_malware_protection
    eks_audit_logs               = var.enable_eks_audit_logs
    rds_login_events             = var.enable_rds_login_events
    publishing_destination       = var.enable_publishing_destination
  }
}
