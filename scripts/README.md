# Infrastructure Automation Scripts

This directory contains production-ready automation scripts for deploying, validating, and managing the PaySecure Multi-Region Disaster Recovery infrastructure.

---

# Directory Structure

```text
scripts/
├── bootstrap.sh
├── validate.sh
├── deploy.sh
├── destroy.sh
└── README.md
```

---

# Prerequisites

Ensure the following tools are installed before running any script.

| Tool | Required |
|-------|-----------|
| Git | ✅ |
| AWS CLI | ✅ |
| Terraform | ✅ |
| kubectl | ✅ |
| Helm | ✅ |

AWS CLI must be authenticated.

```bash
aws configure
```

Verify credentials.

```bash
aws sts get-caller-identity
```

---

# Supported Environments

The scripts support the following environments.

- dev
- prod

---

# Script Overview

## bootstrap.sh

Verifies that the local machine is ready.

Checks include:

- Git
- Terraform
- AWS CLI
- kubectl
- Helm
- AWS Authentication
- Terraform directory
- Backend prerequisites

Example

```bash
./scripts/bootstrap.sh
```

---

## validate.sh

Runs infrastructure validation.

Performs:

- terraform fmt
- terraform init
- terraform validate
- optional TFLint
- module validation

Development

```bash
./scripts/validate.sh dev
```

Production

```bash
./scripts/validate.sh prod
```

---

## deploy.sh

Deploys infrastructure.

Workflow

1. Terraform Format
2. Terraform Init
3. Terraform Validate
4. Terraform Plan
5. Approval
6. Terraform Apply

Development

```bash
./scripts/deploy.sh dev
```

Production

```bash
./scripts/deploy.sh prod
```

---

## destroy.sh

Safely destroys infrastructure.

Features

- Environment validation
- Double confirmation for production
- Terraform destroy
- Production safety checks

Development

```bash
./scripts/destroy.sh dev
```

Production

```bash
./scripts/destroy.sh prod
```

---

# Recommended Workflow

## Initial Setup

```bash
./scripts/bootstrap.sh
```

---

## Validate Configuration

```bash
./scripts/validate.sh dev
```

---

## Deploy Development

```bash
./scripts/deploy.sh dev
```

---

## Validate Production

```bash
./scripts/validate.sh prod
```

---

## Deploy Production

```bash
./scripts/deploy.sh prod
```

---

# Troubleshooting

## Terraform Initialization Failed

Verify:

- AWS credentials
- Backend configuration
- Internet connectivity
- IAM permissions

---

## Validation Failed

Run

```bash
terraform fmt -recursive
terraform validate
```

Review Terraform output and resolve configuration issues.

---

## Deployment Failed

Verify:

- Remote state backend
- Required IAM permissions
- Terraform version
- AWS Region configuration
- Resource quotas

---

## Destroy Failed

Check:

- Resource dependencies
- IAM permissions
- Terraform state consistency

---

# Best Practices

- Always validate before deployment.
- Review Terraform plans before applying.
- Use remote state with locking.
- Never commit secrets or `.tfvars` files.
- Protect the `main` branch with pull requests.
- Enable GitHub Actions for automated validation.
- Regularly update Terraform providers.
- Test all infrastructure changes in the development environment before deploying to production.

---

# Script Execution Order

```text
bootstrap.sh
        │
        ▼
validate.sh
        │
        ▼
deploy.sh
        │
        ▼
Application Deployment
        │
        ▼
Monitoring
        │
        ▼
destroy.sh (only when required)
```

---

# License

This project is licensed under the MIT License.