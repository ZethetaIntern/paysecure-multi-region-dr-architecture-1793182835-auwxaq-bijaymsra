# AWS Services Operations Runbook

This runbook provides standardized operational procedures for managing AWS services used by the **PaySecure Multi-Region Disaster Recovery Architecture**.

It covers identity management, networking, security, monitoring, messaging, backup, automation, governance, and operational best practices.

---

# Objectives

This runbook is designed to:

- Standardize AWS operations
- Maintain service availability
- Improve operational efficiency
- Strengthen security posture
- Ensure compliance
- Support disaster recovery

---

# AWS Services Covered

| Service | Purpose |
|----------|---------|
| IAM | Identity & Access Management |
| ACM | TLS Certificate Management |
| WAF | Web Application Firewall |
| CloudTrail | Audit Logging |
| AWS Config | Compliance Monitoring |
| GuardDuty | Threat Detection |
| Security Hub | Security Posture Management |
| Lambda | Serverless Automation |
| EventBridge | Event Routing |
| SNS | Notifications |
| SQS | Message Queue |
| AWS Backup | Backup Management |
| CloudWatch | Monitoring & Alerting |

---

# Daily Operational Checks

Verify:

- AWS Service Health
- CloudWatch alarms
- IAM changes
- Security findings
- Backup jobs
- Certificate status
- EventBridge rules
- Lambda executions

---

# IAM Operations

Review:

- IAM Users
- IAM Roles
- Policies
- MFA enforcement
- Access Keys
- Service Accounts

Recommended checks:

- Remove unused users
- Rotate access keys
- Review administrator permissions
- Verify least privilege

AWS CLI:

```bash
aws iam list-users

aws iam list-roles
```

---

# ACM Certificate Management

Review:

- Certificate validity
- Expiration dates
- Renewal status
- Domain validation

AWS CLI:

```bash
aws acm list-certificates
```

If a certificate is nearing expiration:

1. Request or renew certificate.
2. Validate ownership.
3. Attach to ALB.
4. Verify HTTPS connectivity.

---

# AWS WAF Operations

Verify:

- Web ACL
- Managed Rules
- Rate Limiting
- IP Sets
- Logging

Monitor:

- Blocked requests
- Allowed requests
- Top attacking IPs
- Geographic traffic

AWS CLI:

```bash
aws wafv2 list-web-acls
```

---

# CloudTrail Operations

Verify:

- Trail enabled
- Multi-region logging
- Log delivery
- S3 destination
- Log integrity validation

Review:

- IAM activity
- Security events
- Infrastructure changes

AWS CLI:

```bash
aws cloudtrail describe-trails
```

---

# AWS Config Operations

Confirm:

- Recorder enabled
- Delivery channel
- Config rules
- Compliance status

Review:

- Non-compliant resources
- Drift detection
- Resource history

AWS CLI:

```bash
aws configservice describe-configuration-recorders
```

---

# GuardDuty Operations

Review findings daily.

Common finding categories:

- Credential compromise
- Reconnaissance
- Crypto mining
- Malware
- Suspicious API activity

Workflow:

```text
Finding
   │
   ▼
Review
   │
   ▼
Validate
   │
   ▼
Contain
   │
   ▼
Recover
```

---

# Security Hub Operations

Review:

- Critical findings
- High findings
- Failed controls
- CIS Benchmark status
- AWS Foundational Security Best Practices

Prioritize remediation based on severity and business impact.

---

# Lambda Operations

Verify:

- Successful executions
- Error count
- Duration
- Concurrency
- Dead Letter Queue (if configured)

AWS CLI:

```bash
aws lambda list-functions
```

Review CloudWatch Logs for execution failures.

---

# EventBridge Operations

Verify:

- Rules enabled
- Targets healthy
- Event delivery
- Failed invocations

AWS CLI:

```bash
aws events list-rules
```

---

# SNS Operations

Review:

- Topic configuration
- Subscriptions
- Delivery status
- Failed notifications

Confirm alerts reach intended recipients.

---

# SQS Operations

Monitor:

- Queue depth
- Message age
- Dead Letter Queue
- Processing failures

AWS CLI:

```bash
aws sqs list-queues
```

Investigate growing queues before they affect application performance.

---

# AWS Backup Operations

Verify:

- Backup plans
- Vault health
- Backup completion
- Cross-region copy
- Restore points

AWS CLI:

```bash
aws backup list-backup-plans
```

---

# CloudWatch Operations

Review:

- Alarms
- Metrics
- Dashboards
- Logs
- Anomaly detection

Verify:

- No unresolved critical alarms
- Metrics are current
- Dashboards functioning correctly

---

# Service Health Monitoring

Review AWS Health Dashboard for:

- Regional issues
- Scheduled maintenance
- Service degradation
- Security advisories

Escalate critical AWS service disruptions according to incident management procedures.

---

# Troubleshooting

## IAM Access Issues

Verify:

- IAM policy
- Role trust relationship
- Permissions boundary
- MFA requirements

---

## Expired Certificate

Check:

- ACM renewal
- Domain validation
- ALB listener configuration

---

## Lambda Failures

Investigate:

- CloudWatch Logs
- Timeout
- Memory allocation
- IAM permissions
- Event source mapping

---

## Backup Failure

Review:

- IAM permissions
- Backup vault
- Resource selection
- Retention policy

---

## EventBridge Delivery Failure

Verify:

- Rule enabled
- Event pattern
- Target permissions
- Invocation logs

---

# Operational Checklist

Daily:

- [ ] CloudWatch healthy
- [ ] GuardDuty reviewed
- [ ] Security Hub reviewed
- [ ] Backup jobs successful
- [ ] IAM changes reviewed

Weekly:

- [ ] WAF rules reviewed
- [ ] ACM certificates checked
- [ ] Config compliance reviewed
- [ ] Lambda execution reviewed

Monthly:

- [ ] IAM audit completed
- [ ] Backup restore tested
- [ ] Security posture reviewed
- [ ] AWS service inventory updated

---

# Best Practices

- Enforce least-privilege IAM policies.
- Enable MFA for privileged accounts.
- Rotate secrets and credentials regularly.
- Review AWS Config compliance frequently.
- Monitor GuardDuty and Security Hub findings daily.
- Automate operational tasks with Lambda and EventBridge.
- Test backup and restore procedures regularly.
- Keep CloudTrail enabled across all regions.

---

# Summary

This AWS Services Operations Runbook provides standardized procedures for operating and maintaining core AWS services, ensuring secure, compliant, and highly available cloud operations across the PaySecure Multi-Region Disaster Recovery Architecture.