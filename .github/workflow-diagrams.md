# GitHub Workflow Diagrams

This document provides a high-level overview of all GitHub Actions workflows used in this repository.

---

# Repository Automation Architecture

```text
                    +----------------------+
                    | Developer Push / PR  |
                    +----------+-----------+
                               |
                               v
                  +--------------------------+
                  | GitHub Actions Platform  |
                  +------------+-------------+
                               |
        +----------------------+----------------------+
        |                      |                      |
        v                      v                      v
   CI/CD Workflows      Security Workflows     Governance
        |                      |                  |
        +----------+-----------+------------------+
                   |
                   v
          Reports / Artifacts / Releases
```

---

# CI/CD Pipeline

```text
Developer
    |
    v
Git Push
    |
    v
Terraform Validation
    |
    v
Build
    |
    v
Tests
    |
    v
Docker Build
    |
    v
Security Scan
    |
    v
Release Validation
    |
    v
GitHub Release
```

---

# Security Workflow

```text
Source Code
      |
      +------------------------------+
      |                              |
      v                              v
 Secret Scan                    CodeQL
      |                              |
      +--------------+---------------+
                     |
                     v
            Dependency Review
                     |
                     v
          License Compliance
                     |
                     v
          OpenSSF Scorecards
                     |
                     v
         GitHub Security Dashboard
```

---

# Terraform Workflow

```text
Terraform Code
       |
       v
terraform fmt
       |
       v
terraform validate
       |
       v
terraform plan
       |
       +-------------+
       |             |
       | Apply?      |
       |             |
       +------+------+
              |
             Yes
              |
              v
terraform apply
```

---

# Release Pipeline

```text
Merge to main
      |
      v
Version Tag
      |
      v
Release Workflow
      |
      v
Release Validation
      |
      v
GitHub Release
      |
      v
Artifacts Published
```

---

# Documentation Pipeline

```text
Markdown Changes
        |
        v
Markdown Lint
        |
        v
Link Check
        |
        v
Spell Check
        |
        v
Documentation Artifact
```

---

# Repository Maintenance

```text
Weekly Scheduler
        |
        +----------------------+
        |                      |
        v                      v
Repository Cleanup       Repository Backup
        |                      |
        +-----------+----------+
                    |
                    v
Repository Health Report
                    |
                    v
Repository Metrics
                    |
                    v
Repository Dashboard
```

---

# Compliance Pipeline

```text
Compliance Workflow
         |
         +--------------------------+
         |                          |
         v                          v
Repository Policy            Required Files
         |                          |
         +------------+-------------+
                      |
                      v
             Governance Report
```

---

# Reusable Workflow Relationships

```text
                 Reusable Workflows

          +--------------------------+
          | reusable-build.yml       |
          +------------+-------------+
                       |
                       v
Application Builds

          +--------------------------+
          | reusable-docker.yml      |
          +------------+-------------+
                       |
                       v
Container Images

          +--------------------------+
          | reusable-terraform.yml   |
          +------------+-------------+
                       |
                       v
Infrastructure

          +--------------------------+
          | reusable-security.yml    |
          +------------+-------------+
                       |
                       v
Security Validation

          +--------------------------+
          | reusable-release.yml     |
          +------------+-------------+
                       |
                       v
GitHub Releases

          +--------------------------+
          | reusable-notify.yml      |
          +------------+-------------+
                       |
                       v
Notifications
```

---

# Scheduled Automation Timeline

| Workflow | Schedule |
|----------|----------|
| Cleanup | Weekly |
| Compliance | Weekly |
| Repository Health | Weekly |
| Metrics | Weekly |
| Repository Report | Weekly |
| Workflow Dashboard | Weekly |
| Repository Backup | Weekly |
| OpenSSF Scorecards | Weekly |

---

# Workflow Categories

## Continuous Integration

- Terraform
- Build
- Docker
- Documentation
- Actionlint

---

## Security

- CodeQL
- Secret Scanning
- Dependency Review
- License Compliance
- Dependency Submission
- OpenSSF Scorecards

---

## Governance

- Compliance
- Repository Health
- Repository Report
- Metrics
- Workflow Dashboard

---

## Maintenance

- Cleanup
- Backup
- Reports

---

## Release

- Release Validation
- Release Workflow
- Release Drafter
- Auto Merge

---

# Repository Governance Architecture

```text
                    Repository
                         |
      +------------------+------------------+
      |                  |                  |
      v                  v                  v
   Security         Automation         Compliance
      |                  |                  |
      +---------+--------+------------------+
                |
                v
        Repository Health
                |
                v
         Weekly Reporting
```

---

# Best Practices

- Use reusable workflows whenever possible.
- Keep workflows independent and modular.
- Enforce branch protection.
- Require status checks before merging.
- Review security findings regularly.
- Monitor scheduled workflow executions.
- Keep documentation synchronized with automation.
- Periodically review workflow permissions using the principle of least privilege.

---

# Summary

The repository automation is organized into independent workflow categories covering CI/CD, security, governance, maintenance, reporting, and release management. Reusable workflows reduce duplication, while scheduled workflows provide continuous validation and operational visibility.