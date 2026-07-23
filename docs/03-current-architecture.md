# Current Production Architecture

# Overview

The existing PaySecure Gateway platform is deployed entirely within the **AWS Mumbai Region (ap-south-1)**. The infrastructure is highly available across three Availability Zones but lacks regional redundancy, making it vulnerable to complete regional failures.

---

# Current AWS Region

| Property | Value |
|----------|-------|
| Cloud Provider | AWS |
| Primary Region | ap-south-1 (Mumbai) |
| Availability Zones | 3 |
| Deployment Model | Single Region |

---

# Architecture Overview

```
                    Internet
                        │
                Amazon Route53
                        │
                  AWS WAF
                        │
         Application Load Balancer (ALB)
                        │
          Amazon EKS Kubernetes Cluster
                        │
 ┌───────────────┬───────────────┬───────────────┐
 │               │               │               │
Payment API  Transaction     Settlement     Fraud Service
              Processor         Engine
 │               │               │               │
 └───────────────┴───────────────┴───────────────┘
                        │
      ┌───────────┬────────────┬───────────────┐
      │           │            │               │
 Aurora PG   DynamoDB     Redis Cache     Amazon MSK
```

---

# Compute Layer

## Amazon EKS

| Property | Value |
|----------|-------|
| Platform | Amazon EKS |
| Worker Nodes | 24 |
| Availability Zones | 3 |
| Auto Scaling | Enabled |
| Total Microservices | 12 |
| Container Runtime | Docker |
| Orchestration | Kubernetes |

### Microservices

- Payment API
- Transaction Processor
- Settlement Engine
- Fraud Detection
- Merchant Portal
- Notification Service
- Reconciliation Worker
- Audit Logger
- Tokenization Service
- Webhook Dispatcher
- Rate Limiter
- Health Monitor

---

# Database Layer

## Aurora PostgreSQL

| Property | Value |
|----------|-------|
| Engine | Aurora PostgreSQL 15 |
| Writer | 1 |
| Reader Replicas | 2 |
| Deployment | Multi-AZ |
| Storage | Encrypted |

Stores:

- Payment Transactions
- Merchant Data
- Settlement Records
- Tokenized Card Data
- Configuration Data

---

## DynamoDB

Purpose:

- Session Management
- Idempotency Keys
- Fast Lookups

Capacity

- 10,000 RCU
- 5,000 WCU

---

## ElastiCache Redis

Purpose

- Merchant Cache
- Rate Limiting
- Session Cache
- Frequently Accessed Data

Deployment

- Cluster Mode Enabled

---

# Messaging Layer

## Amazon MSK (Kafka)

| Property | Value |
|----------|-------|
| Brokers | 6 |
| Retention | 7 Days |
| Peak Throughput | 50,000 Messages/sec |

Topics include

- Transaction Events
- Settlement Events
- Notifications
- Audit Logs
- Webhooks

---

# Networking

Components

- Dedicated VPC
- Private Subnets
- Public Subnets
- NAT Gateway
- Internet Gateway
- Transit Gateway
- Route Tables
- Security Groups
- Network ACLs
- AWS PrivateLink

---

# Traffic Flow

```
Client

↓

Route53

↓

AWS WAF

↓

Application Load Balancer

↓

Amazon EKS

↓

Aurora PostgreSQL
DynamoDB
Redis
Kafka
```

---

# Security

Services Used

- AWS IAM
- AWS KMS
- AWS Secrets Manager
- AWS WAF
- AWS GuardDuty
- AWS CloudTrail

Security Features

- Encryption at Rest
- TLS 1.3
- IAM Roles
- Secret Rotation
- Audit Logging
- PCI Network Segmentation

---

# Monitoring

Monitoring Stack

- Amazon CloudWatch
- Prometheus
- Grafana
- ELK Stack
- Jaeger
- PagerDuty

Monitored Metrics

- Infrastructure Health
- Application Metrics
- Database Metrics
- Kafka Metrics
- Redis Metrics
- Kubernetes Metrics
- Business Transactions

---

# Current Limitations

| Component | Limitation |
|------------|------------|
| Compute | Single AWS Region |
| Database | Regional Only |
| DynamoDB | No Global Table |
| Redis | No Cross-Region Replication |
| Kafka | No DR Cluster |
| DNS | Single Endpoint |
| Monitoring | Region Dependent |
| Disaster Recovery | Manual Process |

---

# Identified Single Points of Failure

- AWS Region Failure
- Regional Database Failure
- Regional Kafka Failure
- Regional Cache Failure
- DNS Dependency
- Regional Monitoring Stack

---

# Summary

The existing architecture provides high availability within a single AWS Region using Multi-AZ deployments but does not provide protection against complete regional outages. A multi-region disaster recovery strategy is required to achieve the target availability, RPO, and RTO objectives.
