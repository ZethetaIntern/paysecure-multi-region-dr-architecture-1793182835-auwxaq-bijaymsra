# Terraform Infrastructure

## Overview

This directory contains the Infrastructure as Code (IaC) for deploying the PaySecure Multi-Region Disaster Recovery Architecture on AWS using Terraform.

The infrastructure provisions identical environments in:

- Primary Region: Mumbai (ap-south-1)
- Disaster Recovery Region: Hyderabad (ap-south-2)

---

# Objectives

- Infrastructure as Code
- Repeatable deployments
- Version-controlled infrastructure
- Automated provisioning
- Production-ready architecture
- Multi-Region deployment

---

# Architecture Components

## Networking

- VPC
- Public Subnets
- Private Application Subnets
- Private Database Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- Network ACLs

---

## Compute

- Amazon EKS
- Managed Node Groups
- IAM Roles
- Auto Scaling

---

## Database

- Aurora PostgreSQL Global Database
- DynamoDB Global Tables
- ElastiCache Redis Global Datastore

---

## Messaging

- Amazon MSK
- MSK Replicator

---

## Security

- IAM
- AWS KMS
- AWS WAF
- Secrets Manager
- GuardDuty
- Security Hub

---

## Monitoring

- CloudWatch
- SNS
- Log Groups

---

# Directory Structure

```
terraform/

├── providers.tf
├── versions.tf
├── backend.tf
├── variables.tf
├── outputs.tf

├── terraform.tfvars.example

├── modules/
│
├── environments/
│   ├── production/
│   └── disaster-recovery/
│
└── scripts/
```

---

# Deployment Order

1. Configure backend
2. Configure providers
3. Create networking
4. Deploy security
5. Deploy EKS
6. Deploy databases
7. Deploy messaging
8. Configure monitoring
9. Validate deployment

---

# Terraform Version

Terraform >= 1.8

---

# AWS Provider

hashicorp/aws

---

# Remote State

Terraform state is stored remotely in Amazon S3 with DynamoDB state locking.

---

# Commands

Initialize

```bash
terraform init
```

Validate

```bash
terraform validate
```

Format

```bash
terraform fmt -recursive
```

Plan

```bash
terraform plan
```

Apply

```bash
terraform apply
```

Destroy

```bash
terraform destroy
```

---

# Best Practices

- Remote state enabled
- State locking enabled
- Modular design
- Reusable components
- Environment isolation
- Version pinning
- Least privilege IAM
- Git version control

---

# Status

Terraform implementation is organized into reusable modules that can deploy both the Primary and Disaster Recovery environments consistently and securely.
