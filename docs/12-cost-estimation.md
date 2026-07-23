# Cost Estimation

# Overview

This document provides an estimated monthly operational cost for the proposed Multi-Region Disaster Recovery architecture. The estimates are based on AWS on-demand pricing and are intended for architectural planning purposes.

---

# Pricing Assumptions

- AWS On-Demand Pricing
- Mumbai (ap-south-1) Primary Region
- Hyderabad (ap-south-2) DR Region
- 24x7 Production Environment
- Active-Passive Deployment
- Moderate Production Workload
- Prices are approximate and exclude taxes

---

# Primary Region Cost

| Service | Estimated Monthly Cost (USD) |
|----------|-----------------------------:|
| Amazon EKS Control Plane | 74 |
| EC2 Worker Nodes | 620 |
| Application Load Balancer | 45 |
| Aurora PostgreSQL | 720 |
| DynamoDB | 180 |
| ElastiCache Redis | 240 |
| Amazon MSK | 480 |
| Amazon S3 | 60 |
| Route53 | 15 |
| NAT Gateways | 110 |
| CloudWatch | 95 |
| Prometheus & Grafana | 80 |
| AWS WAF | 35 |
| AWS Backup | 90 |
| Data Transfer | 180 |

### Primary Region Total

**$3,024 / Month**

---

# Disaster Recovery Region Cost

| Service | Estimated Monthly Cost (USD) |
|----------|-----------------------------:|
| Amazon EKS Control Plane | 74 |
| Standby Worker Nodes | 300 |
| Application Load Balancer | 25 |
| Aurora Global Database | 420 |
| DynamoDB Global Tables | 90 |
| Redis Global Datastore | 120 |
| Amazon MSK Replication | 240 |
| Amazon S3 | 40 |
| NAT Gateways | 80 |
| CloudWatch | 55 |
| AWS Backup | 50 |
| Data Transfer | 120 |

### DR Region Total

**$1,614 / Month**

---

# Shared Services

| Service | Estimated Monthly Cost (USD) |
|----------|-----------------------------:|
| AWS KMS | 30 |
| AWS Secrets Manager | 25 |
| CloudTrail | 20 |
| AWS Config | 18 |
| GuardDuty | 45 |
| Security Hub | 35 |
| IAM Identity Center | 0 |
| SNS Notifications | 12 |

### Shared Services Total

**$185 / Month**

---

# Total Estimated Cost

| Category | Monthly Cost (USD) |
|----------|-------------------:|
| Primary Region | 3,024 |
| DR Region | 1,614 |
| Shared Services | 185 |

## Grand Total

**$4,823 / Month**

---

# Annual Cost

| Category | Annual Cost (USD) |
|----------|------------------:|
| Infrastructure | 57,876 |

---

# Cost Distribution

| Category | Percentage |
|----------|-----------:|
| Compute | 31% |
| Database | 33% |
| Networking | 11% |
| Monitoring | 5% |
| Storage | 4% |
| Security | 4% |
| Backup | 4% |
| Other Services | 8% |

---

# Major Cost Drivers

- Amazon Aurora Global Database
- Amazon EKS Worker Nodes
- Amazon MSK
- Cross-Region Replication
- Data Transfer
- ElastiCache Redis

---

# Active-Passive Savings

Compared with an Active-Active deployment, the proposed architecture provides:

- Lower compute costs
- Reduced database licensing and replication costs
- Lower operational overhead
- Simpler monitoring
- Easier maintenance
- Reduced networking expenses

Estimated savings compared to Active-Active:

**30–40% lower monthly operational cost**

---

# Cost Optimization Recommendations

## Compute

- Use Cluster Autoscaler
- Enable Horizontal Pod Autoscaler
- Use Graviton instances where supported
- Scale DR worker nodes based on demand

---

## Storage

- Apply S3 Lifecycle Policies
- Compress archived logs
- Remove unused EBS volumes
- Use intelligent tiering for backups

---

## Database

- Right-size Aurora instances
- Monitor idle connections
- Enable storage auto-scaling
- Optimize DynamoDB capacity

---

## Networking

- Minimize unnecessary cross-region traffic
- Use VPC Endpoints
- Review NAT Gateway usage
- Optimize ALB rules

---

## Monitoring

- Archive old logs
- Reduce unnecessary metric retention
- Tune alert frequency
- Remove unused dashboards

---

# Cost Monitoring

AWS Services

- AWS Cost Explorer
- AWS Budgets
- AWS Cost Anomaly Detection
- AWS Trusted Advisor

Recommended Budgets

| Budget | Threshold |
|---------|----------:|
| Monthly Infrastructure | $5,000 |
| Database Services | $2,000 |
| Data Transfer | $400 |
| Monitoring | $250 |

---

# Total Cost of Ownership (TCO)

The proposed Active-Passive disaster recovery architecture provides an optimal balance between resilience, regulatory compliance, and operational cost. Although cross-region replication introduces additional expense, the solution significantly reduces business risk while remaining more cost-effective than an Active-Active deployment.

---

# Summary

The estimated operational cost for the proposed architecture is approximately **$4,823 per month ($57,876 annually)**. Continuous monitoring, autoscaling, infrastructure optimization, and regular cost reviews will help maintain predictable cloud spending while meeting high availability and disaster recovery objectives.
