---
name: Infrastructure Change
about: Request or document an infrastructure modification
title: "[INFRA] "
labels: infrastructure
assignees: bijaymsra
---

# Infrastructure Change Request

## Change Summary

Provide a concise description of the infrastructure change.

---

## Change Type

- [ ] New Infrastructure
- [ ] Infrastructure Update
- [ ] Configuration Change
- [ ] Security Enhancement
- [ ] Networking Change
- [ ] Disaster Recovery
- [ ] Monitoring
- [ ] CI/CD
- [ ] Cost Optimization
- [ ] Performance Improvement
- [ ] Other

---

## Infrastructure Scope

Select all affected components.

- [ ] Terraform
- [ ] VPC
- [ ] Networking
- [ ] Route53
- [ ] ALB
- [ ] WAF
- [ ] ACM
- [ ] EKS
- [ ] Aurora
- [ ] Redis
- [ ] MSK
- [ ] IAM
- [ ] Lambda
- [ ] Secrets Manager
- [ ] CloudWatch
- [ ] Backup
- [ ] GuardDuty
- [ ] Security Hub
- [ ] Inspector
- [ ] GitHub Actions
- [ ] Documentation
- [ ] Other

---

## Business Justification

Explain why this change is required.

---

## Risk Assessment

### Risk Level

- [ ] Low
- [ ] Medium
- [ ] High
- [ ] Critical

### Potential Impact

Describe any expected impact on:

- Availability
- Performance
- Security
- Cost
- Disaster Recovery

---

## Rollback Plan

Describe how this infrastructure change can be reverted safely.

```text
Example:

1. Revert Terraform changes
2. Execute terraform apply
3. Validate infrastructure
4. Verify monitoring
5. Confirm service health
```

---

## Terraform Validation Checklist

- [ ] terraform fmt
- [ ] terraform validate
- [ ] terraform plan reviewed
- [ ] Module validation completed
- [ ] Remote state verified
- [ ] No sensitive values exposed

---

## Security Review

- [ ] Least privilege maintained
- [ ] Security groups reviewed
- [ ] Encryption enabled
- [ ] IAM policies reviewed
- [ ] Secrets managed securely
- [ ] Logging enabled
- [ ] Compliance requirements reviewed

---

## Testing Requirements

- [ ] Development tested
- [ ] Production plan reviewed
- [ ] Backup verified
- [ ] Monitoring verified
- [ ] Disaster Recovery validated
- [ ] Rollback tested

---

## Deployment Plan

Describe the deployment sequence.

```text
Example:

1. Validate Terraform
2. Review Plan
3. Deploy Development
4. Verify Resources
5. Deploy Production
6. Monitor Infrastructure
```

---

## Post-Deployment Verification

- [ ] Infrastructure healthy
- [ ] Monitoring operational
- [ ] Alerts functioning
- [ ] Backups verified
- [ ] Security services operational
- [ ] Documentation updated

---

## Approval Checklist

- [ ] Infrastructure Review
- [ ] Security Review
- [ ] DevOps Review
- [ ] Change Approved
- [ ] Ready for Deployment

---

## Additional Notes

Include any diagrams, references, maintenance windows, or implementation notes.