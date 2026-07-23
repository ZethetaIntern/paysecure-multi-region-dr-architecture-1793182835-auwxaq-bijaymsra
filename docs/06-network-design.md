# Network Design

# Overview

The network architecture is designed to provide secure, highly available, and fault-tolerant communication between the Primary Region (Mumbai) and the Disaster Recovery Region (Hyderabad).

---

# AWS Regions

| Region | Purpose |
|---------|---------|
| ap-south-1 (Mumbai) | Primary Production |
| ap-south-2 (Hyderabad) | Disaster Recovery |

---

# Primary Region (Mumbai)

## VPC

| Property | Value |
|----------|-------|
| CIDR | 10.0.0.0/16 |

### Public Subnets

| AZ | CIDR |
|----|------|
| ap-south-1a | 10.0.1.0/24 |
| ap-south-1b | 10.0.2.0/24 |
| ap-south-1c | 10.0.3.0/24 |

### Private Application Subnets

| AZ | CIDR |
|----|------|
| ap-south-1a | 10.0.11.0/24 |
| ap-south-1b | 10.0.12.0/24 |
| ap-south-1c | 10.0.13.0/24 |

### Private Database Subnets

| AZ | CIDR |
|----|------|
| ap-south-1a | 10.0.21.0/24 |
| ap-south-1b | 10.0.22.0/24 |
| ap-south-1c | 10.0.23.0/24 |

---

# Disaster Recovery Region (Hyderabad)

## VPC

| Property | Value |
|----------|-------|
| CIDR | 10.1.0.0/16 |

### Public Subnets

| AZ | CIDR |
|----|------|
| ap-south-2a | 10.1.1.0/24 |
| ap-south-2b | 10.1.2.0/24 |
| ap-south-2c | 10.1.3.0/24 |

### Private Application Subnets

| AZ | CIDR |
|----|------|
| ap-south-2a | 10.1.11.0/24 |
| ap-south-2b | 10.1.12.0/24 |
| ap-south-2c | 10.1.13.0/24 |

### Private Database Subnets

| AZ | CIDR |
|----|------|
| ap-south-2a | 10.1.21.0/24 |
| ap-south-2b | 10.1.22.0/24 |
| ap-south-2c | 10.1.23.0/24 |

---

# Components

Each Region contains:

- 1 VPC
- 3 Public Subnets
- 3 Private Application Subnets
- 3 Private Database Subnets
- Internet Gateway
- NAT Gateway (3)
- Route Tables
- Security Groups
- Network ACLs

---

# Traffic Flow

```

Internet

↓

Amazon Route53

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

# Cross-Region Connectivity

- AWS Transit Gateway
- AWS Backbone Network
- TLS 1.3 Encryption
- Private Communication Only

---

# Route53

Routing Policy

- Failover Routing Policy

Health Checks

- Primary ALB
- EKS API
- Application Health Endpoint

TTL

- 30 Seconds

---

# Load Balancer

Primary Region

- Internet-facing ALB
- HTTPS (443)
- TLS 1.3

DR Region

- Internet-facing ALB
- Standby
- Activated during failover

---

# Security Groups

## ALB

Inbound

- HTTPS (443)

Outbound

- EKS Worker Nodes

---

## EKS Worker Nodes

Inbound

- ALB
- Kubernetes Control Plane

Outbound

- Aurora
- DynamoDB
- Redis
- Kafka
- Internet (via NAT)

---

## Aurora

Inbound

- PostgreSQL (5432)
- EKS Only

Outbound

- Cross-Region Replication

---

## Redis

Inbound

- Redis (6379)
- EKS Only

---

## Kafka

Inbound

- Kafka Brokers
- Internal Services

Outbound

- Cross-Region Replication

---

# Network ACL Rules

Allow

- HTTPS
- PostgreSQL
- Redis
- Kafka
- Kubernetes
- Internal VPC Communication

Deny

- All Unauthorized Traffic

---

# AWS Services Used

- Amazon VPC
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- Network ACLs
- Route53
- Application Load Balancer
- AWS Transit Gateway
- AWS WAF

---

# High Availability

- Multi-AZ VPC Design
- Three Availability Zones
- Redundant NAT Gateways
- Redundant ALBs
- Cross-Region Connectivity
- Automatic DNS Failover

---

# Network Security

- Private Database Subnets
- Private Application Subnets
- Least Privilege Security Groups
- TLS 1.3 Encryption
- KMS Encryption
- AWS WAF
- VPC Flow Logs
- AWS Network Firewall (Optional)

---

# Summary

The proposed network architecture provides secure, highly available, multi-region connectivity with isolated workloads, private database access, automated DNS failover, and resilient networking to support disaster recovery objectives.
