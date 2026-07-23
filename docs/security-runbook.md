# Security Operations Runbook

This runbook defines the operational procedures for responding to security incidents affecting the **PaySecure Multi-Region Disaster Recovery Architecture**.

It provides guidance for incident detection, triage, containment, eradication, recovery, evidence collection, and post-incident analysis.

---

# Purpose

The objectives of this runbook are to:

- Protect critical infrastructure
- Minimize security impact
- Standardize incident response
- Preserve forensic evidence
- Restore services safely
- Improve future security posture

---

# Security Incident Lifecycle

```text
Detection
     │
     ▼
Triage
     │
     ▼
Containment
     │
     ▼
Investigation
     │
     ▼
Eradication
     │
     ▼
Recovery
     │
     ▼
Post-Incident Review
```

---

# Incident Severity Classification

| Severity | Description | Response Target |
|----------|-------------|-----------------|
| Critical | Active compromise, ransomware, credential theft | Immediate |
| High | Unauthorized access or privilege escalation | < 30 minutes |
| Medium | Suspicious behavior requiring investigation | < 2 hours |
| Low | Informational or policy violations | Next business day |

---

# Detection Sources

Security events may originate from:

- AWS GuardDuty
- AWS Security Hub
- AWS CloudTrail
- AWS Config
- Amazon CloudWatch
- Amazon Inspector
- GitHub Security Alerts
- CodeQL
- Secret Scanning
- WAF Logs
- VPC Flow Logs
- Kubernetes Audit Logs
- Prometheus Alerts

---

# Initial Triage

Collect:

- Time detected
- Alert source
- Affected systems
- Impact assessment
- Current severity
- Known indicators of compromise

Determine whether the incident is:

- Credential compromise
- Infrastructure compromise
- Application attack
- Network attack
- Data exposure
- Malware
- Denial of Service

---

# IAM Credential Compromise

Indicators:

- Unexpected API calls
- New IAM users
- Unauthorized role assumptions
- Access from unusual locations

Response:

1. Disable compromised credentials.
2. Rotate access keys.
3. Review CloudTrail activity.
4. Validate IAM policies.
5. Investigate affected resources.
6. Restore least-privilege access.

---

# Secret Rotation

Rotate immediately if:

- Secret exposure is confirmed.
- GitHub secret scanning detects credentials.
- A user account is compromised.
- Vendor guidance requires rotation.

Typical workflow:

```text
Identify Secret
      │
      ▼
Create New Secret
      │
      ▼
Update AWS Secrets Manager
      │
      ▼
Redeploy Workloads
      │
      ▼
Validate Applications
      │
      ▼
Revoke Old Secret
```

---

# WAF Incident Response

Review:

- Blocked requests
- Top IP addresses
- Geographic sources
- Request patterns
- Rate-limited traffic

If malicious activity is confirmed:

- Update WAF rules
- Block offending IPs where appropriate
- Enable rate limiting
- Increase monitoring

---

# Kubernetes Security Response

Verify:

```bash
kubectl get pods -A

kubectl get events -A

kubectl get networkpolicies -A
```

Check for:

- Unexpected pods
- Privileged containers
- Unauthorized images
- Failed authentication attempts
- Excessive restarts

Containment actions:

- Isolate affected workloads.
- Scale down compromised deployments if necessary.
- Rotate Kubernetes secrets.
- Redeploy trusted workloads.

---

# GuardDuty Investigation

Review findings for:

- Credential exfiltration
- Crypto mining
- Unauthorized instance behavior
- Port scanning
- Suspicious API activity
- Malware indicators

Validate affected resources before remediation.

---

# Security Hub Workflow

For each finding:

1. Review severity.
2. Assign owner.
3. Validate impact.
4. Apply remediation.
5. Verify resolution.
6. Close finding with documentation.

---

# Evidence Collection

Preserve:

- CloudTrail logs
- CloudWatch logs
- Kubernetes audit logs
- Application logs
- WAF logs
- VPC Flow Logs
- IAM activity
- Relevant configuration snapshots

Maintain chain of custody according to organizational policies.

---

# Containment

Examples:

- Disable compromised IAM users
- Isolate EC2 instances
- Restrict Security Groups
- Block malicious IP addresses
- Disable compromised API keys
- Revoke temporary credentials

Contain first, then investigate further.

---

# Recovery

Before restoring services:

- Confirm threat removal.
- Validate patched systems.
- Rotate affected credentials.
- Verify monitoring.
- Confirm application integrity.

Restore services gradually while monitoring for recurrence.

---

# Post-Incident Review

Document:

- Timeline
- Root cause
- Impact
- Systems affected
- Recovery actions
- Lessons learned
- Preventive measures

Update documentation and runbooks if procedures change.

---

# Operational Checklist

During an incident:

- [ ] Incident classified
- [ ] Team notified
- [ ] Evidence preserved
- [ ] Threat contained
- [ ] Credentials rotated if required
- [ ] Monitoring enhanced
- [ ] Recovery validated
- [ ] Incident documented

---

# Best Practices

- Follow the principle of least privilege.
- Enable multi-factor authentication.
- Rotate secrets regularly.
- Review IAM permissions periodically.
- Patch systems promptly.
- Monitor security findings continuously.
- Test incident response procedures regularly.
- Keep runbooks and contact information current.

---

# Summary

This Security Operations Runbook provides standardized procedures for detecting, responding to, and recovering from security incidents across AWS infrastructure, Kubernetes workloads, and GitHub automation, helping maintain the confidentiality, integrity, and availability of the PaySecure Multi-Region Disaster Recovery Architecture.