# Security Design

# Overview

The security architecture follows a Zero Trust model and implements multiple layers of protection to secure payment transactions, customer data, and infrastructure while meeting RBI, PCI-DSS v4.0, and NPCI compliance requirements.

---

# Security Principles

- Zero Trust Architecture
- Least Privilege Access
- Defense in Depth
- Encryption Everywhere
- Continuous Monitoring
- Identity-Based Access Control
- Multi-Region Security

---

# Identity and Access Management

## AWS IAM

Policies

- Least Privilege
- Role-Based Access Control (RBAC)
- Service Roles
- Cross-Account Roles

Authentication

- Multi-Factor Authentication (MFA)
- IAM Identity Center (AWS SSO)

Password Policy

- Minimum 14 Characters
- Complexity Enabled
- Rotation Every 90 Days

---

# Kubernetes Security

Authentication

- IAM Roles for Service Accounts (IRSA)

Authorization

- Kubernetes RBAC

Pod Security

- Pod Security Standards (Restricted)
- Non-Root Containers
- Read-Only Root Filesystem
- Drop Linux Capabilities

Network

- Kubernetes Network Policies
- Istio mTLS

---

# Encryption

## Data at Rest

| Service | Encryption |
|----------|------------|
| Aurora PostgreSQL | AWS KMS |
| DynamoDB | AWS KMS |
| EBS Volumes | AWS KMS |
| Amazon MSK | AWS KMS |
| ElastiCache Redis | AWS KMS |
| S3 | AWS KMS |

---

## Data in Transit

- TLS 1.3
- HTTPS Only
- mTLS Between Services
- Encrypted Cross-Region Replication

---

# AWS KMS

Configuration

- Multi-Region Keys
- Automatic Rotation
- Customer Managed Keys (CMK)

Used By

- Aurora
- DynamoDB
- EBS
- S3
- Redis
- Kafka
- Secrets Manager

---

# Secrets Management

Service

- AWS Secrets Manager

Stored Secrets

- Database Credentials
- Kafka Credentials
- Redis Passwords
- API Keys
- TLS Certificates
- Partner Bank Credentials

Rotation

- Automatic Every 90 Days

---

# Network Security

Components

- AWS WAF
- Security Groups
- Network ACLs
- Private Subnets
- AWS Transit Gateway
- VPC Flow Logs

Protection

- DDoS Protection
- SQL Injection Protection
- XSS Protection
- IP Reputation Filtering
- Rate Limiting

---

# AWS WAF Rules

- AWS Managed Rules
- SQL Injection Protection
- Cross-Site Scripting Protection
- Bad Bot Protection
- Rate-Based Rules
- Geo Restriction (India)

---

# Logging and Auditing

Services

- AWS CloudTrail
- AWS Config
- Amazon CloudWatch
- VPC Flow Logs

Audit Events

- IAM Changes
- API Calls
- Resource Changes
- Security Events
- Login Events

Retention

- 365 Days

---

# Threat Detection

AWS GuardDuty

Monitors

- Unauthorized Access
- Malware Activity
- Credential Abuse
- Crypto Mining
- Network Anomalies

---

# Compliance Monitoring

AWS Config

Checks

- Encryption Enabled
- Public S3 Buckets
- Security Groups
- IAM Policies
- KMS Configuration
- Logging Enabled

---

# Security Hub

Aggregates Findings From

- GuardDuty
- AWS Config
- Inspector
- IAM Access Analyzer

---

# Backup Security

- Encrypted Backups
- Cross-Region Backup Copy
- Point-in-Time Recovery
- Immutable Backup Retention

---

# Data Protection

Cardholder Data

- Tokenization
- AES-256 Encryption
- Stored Only in India

Merchant Data

- Field-Level Encryption
- Access Logging

Transaction Data

- Encrypted
- Multi-Region Replication

---

# Compliance Mapping

| Standard | Control |
|-----------|---------|
| RBI Data Localisation | Data Stored Only in India |
| PCI-DSS v4.0 | Encryption, Logging, MFA |
| NPCI | Secure Payment Processing |
| ISO 27001 | ISMS Controls |

---

# Security Monitoring

Monitor

- Failed Logins
- Unauthorized API Calls
- Replication Failures
- WAF Events
- IAM Changes
- Privilege Escalation
- Network Anomalies
- Malware Detection

---

# Incident Response

1. Detect Security Event
2. Generate Alert
3. Isolate Affected Resource
4. Investigate Logs
5. Contain Threat
6. Recover Services
7. Perform Root Cause Analysis
8. Update Security Controls

---

# Summary

The proposed security architecture provides layered protection across identity, network, compute, storage, and application components while ensuring regulatory compliance, encryption, continuous monitoring, and secure disaster recovery operations.
