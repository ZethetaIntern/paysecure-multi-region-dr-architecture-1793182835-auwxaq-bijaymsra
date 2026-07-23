# Architecture Diagrams

This document contains logical architecture diagrams for the **PaySecure Multi-Region Disaster Recovery Architecture**.

The diagrams are intended to explain the overall system design, infrastructure layout, networking, security, disaster recovery, monitoring, and deployment workflow.

---

# 1. High-Level System Architecture

```text
                    +----------------------+
                    |      Internet        |
                    +----------+-----------+
                               |
                     Route53 Failover DNS
                               |
            +------------------+------------------+
            |                                     |
            |                                     |
   Primary Region (ap-south-1)         Secondary Region (ap-southeast-1)
            |                                     |
      Application Load Balancer          Application Load Balancer
            |                                     |
        Amazon EKS                         Amazon EKS
            |                                     |
      Microservices                      Microservices
            |                                     |
     Aurora Global DB  <=================> Aurora Secondary
            |
    DynamoDB Global Tables
            |
      Shared AWS Services
```

---

# 2. AWS Multi-Region Topology

```text
                    AWS Global Infrastructure

         +-----------------------------------------------+
         |               Route53 DNS                     |
         +----------------------+------------------------+
                                |
              Health Check & Failover Policy
                                |
          +---------------------+---------------------+
          |                                           |
          v                                           v
  Region A (Primary)                         Region B (DR)
  ------------------                         ------------------
  VPC                                     VPC
  Public Subnets                          Public Subnets
  Private Subnets                         Private Subnets
  EKS Cluster                             EKS Cluster
  Aurora Primary                          Aurora Secondary
  Redis                                   Redis
  MSK                                     MSK
```

---

# 3. VPC Network Architecture

```text
                    VPC

          +-------------------------------+

          Public Subnet A
              |
              +---- ALB
              |
              +---- NAT Gateway

          Public Subnet B
              |
              +---- ALB

          -------------------------------

          Private Subnet A
              |
              +---- EKS Nodes
              +---- Aurora
              +---- Redis

          Private Subnet B
              |
              +---- EKS Nodes
              +---- MSK

          +-------------------------------+
```

---

# 4. Kubernetes Architecture

```text
                   Amazon EKS

          +---------------------------+

              Ingress Controller
                      |
             Kubernetes Services
                      |
      +---------------+---------------+
      |               |               |
      v               v               v
 API Service     Payment Service   User Service

                      |
                 Internal APIs
                      |
                  Aurora Database
```

---

# 5. Database Architecture

```text
               Aurora Global Database

       +-------------------------------+
       | Primary Cluster               |
       | Writer Instance               |
       | Read Replica                  |
       +---------------+---------------+
                       ||
        Global Replication (Async)
                       ||
       +---------------+---------------+
       | Secondary Cluster             |
       | Read Replica                  |
       | Promoted During DR            |
       +-------------------------------+
```

---

# 6. Disaster Recovery Flow

```text
Normal Operation

Users
  |
Route53
  |
Primary Region
  |
Application

------------------------------

Disaster

Primary Region Failure
        |
        v
Health Check Fails
        |
        v
DNS Failover
        |
        v
Secondary Region
        |
Application Restored
```

---

# 7. Monitoring Architecture

```text
Applications
      |
      v
CloudWatch Logs
      |
      +------------------------+
      |                        |
      v                        v
Prometheus                CloudWatch Metrics
      |                        |
      +------------+-----------+
                   |
                   v
              Grafana
                   |
              Dashboards
```

---

# 8. Security Architecture

```text
Internet
    |
AWS WAF
    |
ALB
    |
Security Groups
    |
Private Subnets
    |
EKS
    |
IAM Roles
    |
Secrets Manager
```

---

# 9. CI/CD Pipeline

```text
Developer
     |
Git Push
     |
GitHub Actions
     |
Terraform Validation
     |
Security Checks
     |
Build
     |
Documentation
     |
Release Validation
     |
Production Release
```

---

# 10. Request Flow

```text
User
  |
HTTPS
  |
Route53
  |
AWS WAF
  |
ALB
  |
Ingress
  |
Kubernetes Service
  |
Application Pod
  |
Aurora Database
```

---

# 11. Infrastructure Dependency Diagram

```text
VPC
 |
 +---- Security Groups
 |
 +---- Subnets
 |
 +---- Route Tables
 |
 +---- NAT Gateway
 |
 +---- EKS
 |      |
 |      +---- ALB
 |      +---- IAM
 |
 +---- Aurora
 |
 +---- Redis
 |
 +---- MSK
 |
 +---- CloudWatch
 |
 +---- Route53
```

---

# 12. Component Interaction

```text
Client
   |
Route53
   |
ALB
   |
Ingress Controller
   |
Application Services
   |
+------------------------------+
| Aurora | Redis | MSK | S3    |
+------------------------------+
   |
Monitoring & Logging
```

---

# Diagram Usage

These diagrams are intended for:

- Architecture reviews
- Technical design discussions
- Disaster recovery planning
- Infrastructure documentation
- Knowledge transfer
- Interview demonstrations
- Operational runbooks

---

# Summary

The diagrams in this document provide a logical representation of the PaySecure Multi-Region Disaster Recovery Architecture, illustrating networking, compute, storage, security, monitoring, CI/CD, and disaster recovery relationships across AWS regions.