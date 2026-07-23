# Pull Request

## Summary

Provide a brief description of the changes introduced by this pull request.

---

## Type of Change

Select all that apply.

- [ ] Bug Fix
- [ ] New Feature
- [ ] Infrastructure Change
- [ ] Terraform Module Update
- [ ] Documentation Update
- [ ] CI/CD Pipeline Change
- [ ] Security Improvement
- [ ] Performance Improvement
- [ ] Refactoring
- [ ] Other

---

## Infrastructure Impact

Describe the infrastructure components affected.

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
- [ ] Secrets Manager
- [ ] Lambda
- [ ] CloudWatch
- [ ] Backup
- [ ] GuardDuty
- [ ] Security Hub
- [ ] Inspector
- [ ] Other

---

## Terraform Validation Checklist

- [ ] `terraform fmt` completed
- [ ] `terraform validate` passed
- [ ] `terraform plan` reviewed
- [ ] No sensitive information exposed
- [ ] Remote state verified
- [ ] Module outputs verified
- [ ] Variable validation completed

---

## Testing Checklist

- [ ] Development deployment tested
- [ ] Production plan reviewed
- [ ] Rollback procedure validated
- [ ] Monitoring verified
- [ ] Logging verified
- [ ] Security controls verified
- [ ] Backup strategy validated

---

## Security Review

- [ ] IAM permissions follow least privilege
- [ ] No hardcoded credentials
- [ ] Security groups reviewed
- [ ] Encryption enabled where applicable
- [ ] Secrets stored securely
- [ ] Logging enabled
- [ ] Compliance requirements satisfied

---

## Rollback Plan

Describe how this change can be safely rolled back if deployment fails.

```text
Example:

1. Revert this PR
2. Execute Terraform Apply
3. Validate Infrastructure
4. Verify Monitoring
```

---

## Deployment Notes

Include any deployment instructions or prerequisites.

```text
Example:

- Requires Terraform >= 1.8
- Requires AWS CLI authentication
- Requires Remote Backend
```

---

## Reviewer Checklist

- [ ] Code quality reviewed
- [ ] Infrastructure design reviewed
- [ ] Terraform best practices followed
- [ ] Documentation updated
- [ ] Security reviewed
- [ ] CI/CD passed
- [ ] Ready for deployment

---

## Additional Notes

Provide any additional context for reviewers.

---

## Approval

| Reviewer | Status |
|-----------|--------|
| Infrastructure | ☐ |
| Security | ☐ |
| DevOps | ☐ |
| Final Approval | ☐ |