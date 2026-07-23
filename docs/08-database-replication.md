# Database Replication Strategy

# Overview

The PaySecure Gateway platform uses a multi-database architecture to support transactional workloads, session management, caching, and event streaming. Each data service is configured with an appropriate cross-region replication mechanism to achieve the required Recovery Point Objective (RPO) and Recovery Time Objective (RTO).

---

# Database Services

| Service | Purpose | Replication |
|----------|---------|-------------|
| Aurora PostgreSQL Global Database | Payment Transactions | Cross-Region |
| DynamoDB Global Tables | Sessions & Idempotency | Active-Active |
| ElastiCache Redis Global Datastore | Cache | Cross-Region |
| Amazon MSK | Event Streaming | MSK Replicator |

---

# Aurora PostgreSQL Global Database

## Primary Region

- Mumbai (ap-south-1)
- Read/Write
- Writer Instance
- Reader Instances

## Secondary Region

- Hyderabad (ap-south-2)
- Read-Only
- Automatic Promotion During Disaster

---

# Aurora Architecture

```
                  Aurora Global Database

             Primary Region (Mumbai)

                 Writer Instance
                       │
        ┌──────────────┴──────────────┐
        │                             │
    Reader 1                     Reader 2
                       │
================ Cross-Region Replication ================

                DR Region (Hyderabad)

                 Read Replica
                       │
             Promoted During Disaster
```

---

# Aurora Replication

| Property | Value |
|----------|-------|
| Replication Type | Physical |
| Replication Mode | Asynchronous |
| Average Lag | Less than 1 Second |
| Automatic Promotion | Yes |
| Encryption | AWS KMS |

---

# Failover Process

1. Mumbai Region becomes unavailable.
2. Route53 detects application failure.
3. Aurora Global Database initiates failover.
4. Hyderabad reader is promoted to writer.
5. Application reconnects using the new database endpoint.
6. Traffic is redirected to Hyderabad.
7. Payment processing resumes.

---

# DynamoDB Global Tables

Purpose

- Session Data
- Authentication Tokens
- Idempotency Keys
- Merchant Preferences

Regions

- Mumbai
- Hyderabad

Replication

- Automatic Multi-Master

---

# DynamoDB Architecture

```
Mumbai Region

DynamoDB Global Table

⇅ Automatic Replication ⇅

Hyderabad Region

DynamoDB Global Table
```

---

# DynamoDB Benefits

- Automatic Replication
- Low Latency
- Regional Independence
- No Manual Synchronization
- Highly Available

---

# Redis Global Datastore

Purpose

- Session Cache
- Frequently Accessed Merchant Data
- API Rate Limits
- Temporary Payment Cache

Primary

- Mumbai

Secondary

- Hyderabad

Replication

- Cross-Region Asynchronous

---

# Redis Failover

```
Mumbai Redis

↓

Cross-Region Replication

↓

Hyderabad Redis

↓

Automatic Promotion During Disaster
```

---

# Amazon MSK Replication

Purpose

- Payment Events
- Settlement Events
- Notifications
- Audit Logs

Replication

- Amazon MSK Replicator

Replication Mode

- Continuous

---

# Replication Monitoring

Monitor

- Aurora Replication Lag
- Redis Replication Lag
- DynamoDB Replication Health
- Kafka Replication Status
- Database CPU
- Storage Usage
- Connection Count

Alerts

- Replication Lag > 30 Seconds
- Replica Failure
- Storage Exhaustion
- Database Unavailable

---

# Split-Brain Prevention

Aurora

- Single Writer Architecture
- Controlled Promotion

Redis

- Single Writable Primary

Kafka

- Controlled Cluster Failover

DynamoDB

- Built-In Conflict Resolution

---

# Backup Strategy

Aurora

- Automated Daily Backup
- Continuous Point-in-Time Recovery
- Cross-Region Snapshots

DynamoDB

- Point-in-Time Recovery
- On-Demand Backup

Redis

- Automatic Snapshots

MSK

- Topic Replication
- Broker Redundancy

---

# Recovery Objectives

| Metric | Target |
|----------|--------|
| RPO | Less than 1 Minute |
| RTO | Less than 5 Minutes |
| Aurora Promotion | Less than 2 Minutes |
| Redis Promotion | Less than 1 Minute |
| DynamoDB Recovery | Immediate |
| Kafka Recovery | Less than 3 Minutes |

---

# Best Practices

- Enable automatic backups.
- Monitor replication lag continuously.
- Test failover quarterly.
- Encrypt all databases using AWS KMS.
- Enable audit logging.
- Restrict database access using Security Groups.
- Use private subnets for all database services.
- Perform periodic disaster recovery drills.

---

# Summary

The database replication architecture ensures that transactional, cached, and event-driven data remains available across both AWS regions. Using Aurora Global Database, DynamoDB Global Tables, Redis Global Datastore, and Amazon MSK Replicator enables rapid recovery, minimal data loss, and compliance with the project's disaster recovery objectives.
