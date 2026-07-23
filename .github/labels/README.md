# GitHub Labels

This document describes the standard labeling strategy used throughout the repository.

## Objectives

The label system helps teams:

- Prioritize work
- Categorize issues
- Organize pull requests
- Track infrastructure changes
- Improve release planning
- Support automation
- Improve reporting

---

# Type Labels

| Label | Purpose |
|--------|---------|
| bug | Software defect |
| enhancement | New functionality |
| documentation | Documentation improvements |
| question | Requires clarification |
| duplicate | Already reported |
| invalid | Invalid request |
| wontfix | Will not be implemented |

---

# Priority Labels

| Label | Meaning |
|--------|---------|
| high-priority | Immediate attention |
| low-priority | Can be scheduled later |

---

# Infrastructure Labels

| Label | Purpose |
|--------|---------|
| terraform | Terraform changes |
| infrastructure | Infrastructure modifications |
| aws | AWS resources |
| kubernetes | Kubernetes resources |
| devops | CI/CD and automation |

---

# Security Labels

| Label | Purpose |
|--------|---------|
| security | Security fixes |
| compliance | Compliance updates |
| disaster-recovery | Disaster Recovery implementation |

---

# Operations Labels

| Label | Purpose |
|--------|---------|
| monitoring | Monitoring improvements |
| performance | Performance optimization |
| cost-optimization | Cloud cost reduction |

---

# Community Labels

| Label | Purpose |
|--------|---------|
| help wanted | Community contribution welcome |
| good first issue | Suitable for new contributors |

---

# Dependency Management

| Label | Purpose |
|--------|---------|
| dependencies | Dependency updates |
| breaking-change | Introduces breaking changes |

---

# Label Usage Guidelines

## Issues

Each issue should contain:

- One type label
- One priority label
- Optional infrastructure label
- Optional security label

Example:

bug
high-priority
aws

---

## Pull Requests

Each pull request should include:

- One change type
- Infrastructure label if applicable
- Security label if applicable

Example:

enhancement
terraform
security

---

## Automation

Several GitHub Actions use labels automatically.

Examples include:

- Dependabot
- Auto Merge
- Stale Workflow
- Release Automation

Changing label names may require updating workflow configurations.

---

# Best Practices

- Keep labels consistent.
- Avoid duplicate meanings.
- Use one primary type label.
- Use priority labels sparingly.
- Apply infrastructure labels only when relevant.
- Review labels during pull request review.
- Remove obsolete labels regularly.

---

# Governance

Repository maintainers are responsible for:

- Creating labels
- Updating descriptions
- Managing colors
- Removing deprecated labels
- Maintaining automation compatibility

---

# References

- GitHub Labels
- GitHub Issues
- GitHub Projects
- GitHub Actions