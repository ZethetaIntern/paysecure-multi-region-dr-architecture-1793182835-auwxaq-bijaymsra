# Contributing Guide

Thank you for contributing to the **PaySecure Multi-Region Disaster Recovery Architecture** project.

This guide describes the standards, workflows, and best practices that all contributors should follow.

---

# Project Overview

This repository contains a production-ready reference implementation for designing and deploying a highly available, multi-region disaster recovery architecture on AWS using Infrastructure as Code.

Primary technologies include:

- AWS
- Terraform
- Kubernetes (Amazon EKS)
- GitHub Actions
- Docker
- Prometheus
- Grafana

---

# Repository Structure

```text
.
├── docs/
├── terraform/
│   ├── environments/
│   ├── modules/
│   └── README.md
├── scripts/
├── .github/
└── README.md
```

---

# Development Workflow

Every contribution should follow this workflow.

```text
Fork Repository
        │
        ▼
Create Feature Branch
        │
        ▼
Develop Changes
        │
        ▼
Run Validation
        │
        ▼
Commit Changes
        │
        ▼
Push Branch
        │
        ▼
Open Pull Request
        │
        ▼
Code Review
        │
        ▼
Merge
```

---

# Branch Naming

Use descriptive branch names.

Examples:

```text
feature/add-aurora-module
feature/eks-upgrade
bugfix/fix-route53-output
hotfix/security-group-rule
release/v1.2.0
docs/update-dr-plan
```

---

# Commit Message Convention

Use concise, meaningful commit messages.

Recommended format:

```text
type(scope): short description
```

Examples:

```text
feat(terraform): add aurora global database
fix(network): correct route table association
docs(dr): update recovery procedures
ci(actions): improve terraform workflow
security(iam): enforce least privilege
refactor(terraform): simplify outputs
```

Common types:

- feat
- fix
- docs
- ci
- chore
- refactor
- test
- security

---

# Coding Standards

## Terraform

- Use consistent formatting.
- Run `terraform fmt`.
- Validate with `terraform validate`.
- Keep modules reusable.
- Avoid hardcoded values.
- Use variables and outputs appropriately.

---

## Shell Scripts

- Use Bash.
- Enable strict mode.

```bash
set -euo pipefail
```

- Add comments for non-obvious logic.
- Validate user input.
- Keep scripts idempotent where possible.

---

## YAML

- Use two-space indentation.
- Keep workflows modular.
- Prefer reusable workflows.
- Follow least-privilege permissions.

---

## Documentation

Documentation should:

- Be written in Markdown.
- Include diagrams when appropriate.
- Be technically accurate.
- Stay synchronized with infrastructure changes.

---

# Pull Request Process

Every Pull Request should include:

- Clear description
- Purpose of the change
- Testing performed
- Infrastructure impact
- Security impact
- Rollback considerations
- Documentation updates

Before requesting review:

- [ ] Code formatted
- [ ] Validation passed
- [ ] Documentation updated
- [ ] Security reviewed
- [ ] Tests completed

---

# Code Review Expectations

Reviewers should verify:

- Correctness
- Readability
- Security
- Maintainability
- Performance
- Documentation quality
- Terraform best practices
- CI/CD compatibility

---

# Testing Requirements

Infrastructure changes should be validated with:

```text
terraform fmt
terraform validate
terraform plan
```

Documentation changes should pass:

- Markdown linting
- Link validation
- Spell checking

GitHub workflows should pass:

- Actionlint
- YAML validation

---

# Security Reporting

Do **not** create public issues for security vulnerabilities.

Instead:

1. Follow the instructions in `SECURITY.md`.
2. Provide sufficient technical detail.
3. Allow maintainers time to investigate.
4. Coordinate disclosure after remediation.

---

# Best Practices

- Keep pull requests focused.
- Avoid unrelated changes.
- Prefer reusable modules.
- Use meaningful commit messages.
- Review automation before merging.
- Follow the principle of least privilege.
- Keep dependencies updated.
- Update documentation alongside code.

---

# Contributor Checklist

Before submitting a Pull Request:

- [ ] Branch created correctly
- [ ] Changes tested
- [ ] Terraform validated
- [ ] Documentation updated
- [ ] Security considered
- [ ] CI checks passing
- [ ] Commit messages follow conventions
- [ ] Pull request template completed

---

# Communication

When discussing changes:

- Be respectful.
- Provide constructive feedback.
- Focus on technical improvements.
- Document design decisions where necessary.

---

# License

By contributing to this repository, you agree that your contributions will be licensed under the project's LICENSE file.

---

# Thank You

Your contributions help improve the reliability, security, and maintainability of this disaster recovery reference architecture.