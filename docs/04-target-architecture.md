# Target Multi-Region Architecture

# Overview

The proposed solution transforms the existing single-region deployment into a **Multi-Region Active-Passive Disaster Recovery Architecture** across AWS India Regions.

Primary Region

- Mumbai (ap-south-1)

Disaster Recovery Region

- Hyderabad (ap-south-2)

The architecture is designed to achieve:

- Availability: 99.99%
- RPO: < 1 Minute
- RTO: < 5 Minutes

---

# High-Level Architecture

```
                        Users
                          │
                    Amazon Route53
               (Failover Routing Policy)
                          │
          ┌───────────────┴────────────────┐
          │                                │
          │                                │
 Primary Region                     DR Region
 Mumbai (ap-south-1)             Hyderabad (ap-south-2)

      AWS WAF                         AWS WAF
          │                              │
      ALB (Primary)                  ALB (Standby)
          │                              │
      Amazon EKS                    Amazon EKS
          │                              │
 ┌────────┼────────┐             ┌────────┼────────┐
 │        │        │             │        │        │
Aurora  Redis    MSK         Aurora   Redis     MSK
Global  Global Mirror       Global   Global   Mirror
DB      DS      Cluster      DB      DS      Cluster
 │
 DynamoDB Global Tables
```

---

# Architecture Model

| Component | Design |
|----------|--------|
| Deployment | Active-Passive |
| Primary Region | Mumbai |
| DR Region | Hyderabad |
| Failover | Automatic |
| DNS | Route53 Failover |
| Infrastructure | Terraform |
| Containers | Kubernetes |

---

# Compute Layer

## Amazon EKS

Primary Region

- Production Traffic
- All Microservices Active
- Auto Scaling Enabled

DR Region

- Standby Cluster
- Ready for Automatic Promotion
- Synchronized Configuration

---

# Database Layer

## Aurora PostgreSQL Global Database

Primary

- Writer Instance

Secondary

- Cross-Region Reader
- Automatic Promotion During DR

Replication

- Cross-Region
- Near Real-Time

---

## DynamoDB Global Tables

Deployment

- Mumbai
- Hyderabad

Replication

- Multi-Region
- Automatic

Purpose

- Session Management
- Idempotency Keys

---

## ElastiCache Redis Global Datastore

Primary

- Read/Write

Secondary

- Read Only

Failover

- Automatic Promotion

---

# Messaging Layer

## Amazon MSK

Primary Region

- Active Cluster

DR Region

- Replicated Cluster

Replication

- MSK Replicator

---

# Networking

Each region contains:

- Dedicated VPC
- Public Subnets
- Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- Network ACLs

Connectivity

- Transit Gateway
- VPC Peering (if required)
- Private AWS Backbone

---

# Traffic Routing

Normal Operation

```
Users

↓

Route53

↓

Mumbai Region

↓

ALB

↓

Amazon EKS

↓

Databases
```

During Disaster

```
Users

↓

Route53

↓

Hyderabad Region

↓

ALB

↓

Amazon EKS

↓

Promoted Databases
```

---

# Security

Services

- IAM
- KMS Multi-Region Keys
- AWS WAF
- Secrets Manager
- GuardDuty
- Security Hub
- CloudTrail
- AWS Config

Security Controls

- Encryption at Rest
- TLS 1.3
- IAM Least Privilege
- Secret Rotation
- Continuous Compliance

---

# Monitoring

Centralized Monitoring

- CloudWatch
- Prometheus
- Grafana
- Alertmanager
- Jaeger

Critical Alerts

- Region Failure
- Replication Lag
- Database Health
- Kafka Health
- Redis Health
- Kubernetes Health
- DNS Failover

---

# Backup Strategy

- AWS Backup
- Cross-Region Snapshots
- Automated Retention
- Point-in-Time Recovery
- Encrypted Backups

---

# Disaster Recovery Flow

1. Route53 detects Mumbai failure
2. Health Check fails
3. Traffic redirected to Hyderabad
4. Aurora promoted
5. Redis promoted
6. MSK consumers activated
7. Kubernetes services become active
8. Monitoring validates recovery
9. Business operations continue

---

# Expected Outcomes

| Metric | Target |
|---------|---------|
| Availability | 99.99% |
| RPO | < 1 Minute |
| RTO | < 5 Minutes |
| Automated Failover | Yes |
| Zero Single Point of Failure | Yes |
| Multi-Region Deployment | Yes |
| Infrastructure as Code | Yes |
| Compliance Ready | Yes |

---

# Architecture Summary

The proposed Active-Passive Multi-Region Disaster Recovery Architecture provides automated failover, near real-time replication, centralized monitoring, and compliance with RBI, PCI-DSS, and NPCI requirements while minimizing operational complexity and infrastructure costs compared to an Active-Active deployment.
