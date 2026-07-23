# Active-Active vs Active-Passive Analysis

# Objective

Evaluate the two disaster recovery architectures and select the most appropriate solution for PaySecure Gateway.

---

# Architecture Options

## Option 1

**Active-Active**

Both AWS regions simultaneously process production traffic.

---

## Option 2

**Active-Passive**

The primary region serves all production traffic while the secondary region remains synchronized and automatically takes over during a disaster.

---

# Comparison

| Criteria | Active-Active | Active-Passive |
|------------|--------------|----------------|
| Availability | Excellent | Excellent |
| Infrastructure Cost | Very High | Moderate |
| Operational Complexity | Very High | Moderate |
| Database Consistency | Complex | Simple |
| Split-Brain Risk | High | Very Low |
| Failover Time | Near Zero | < 5 Minutes |
| Data Consistency | Complex | Strong |
| Maintenance | Difficult | Easier |
| Compliance | More Complex | Easier |
| Recommended for PaySecure | No | Yes |

---

# Active-Active Advantages

- Near-zero downtime
- Better traffic distribution
- Lower user latency
- Higher regional resilience
- Better utilization of resources

---

# Active-Active Challenges

- Split-brain risk
- Transaction ordering issues
- Duplicate payment risk
- Complex conflict resolution
- Difficult database synchronization
- Higher operational cost
- Higher engineering effort
- Complex monitoring

---

# Active-Passive Advantages

- Simple architecture
- Strong data consistency
- Single database writer
- Easier compliance
- Lower infrastructure cost
- Faster implementation
- Easier monitoring
- Easier disaster recovery

---

# Active-Passive Limitations

- DR region remains mostly idle
- Small failover window
- Slightly higher recovery time than Active-Active

---

# Decision Matrix

| Requirement | Weight | Active-Active | Active-Passive |
|--------------|--------|--------------|----------------|
| Availability | High | ✅ | ✅ |
| RPO | High | ✅ | ✅ |
| RTO | High | ✅ | ✅ |
| Simplicity | High | ❌ | ✅ |
| Cost | Medium | ❌ | ✅ |
| Compliance | High | ❌ | ✅ |
| Operational Risk | High | ❌ | ✅ |
| Data Consistency | High | ❌ | ✅ |

---

# Selected Architecture

**Active-Passive Multi-Region Architecture**

---

# Justification

The Active-Passive architecture is selected because it:

- Meets 99.99% availability requirements
- Achieves RPO < 1 minute
- Achieves RTO < 5 minutes
- Minimizes split-brain risk
- Ensures strong transaction consistency
- Simplifies disaster recovery operations
- Reduces infrastructure cost
- Supports RBI and PCI-DSS compliance
- Aligns with production payment system best practices

---

# Risks

| Risk | Mitigation |
|------|------------|
| Regional Failure | Automatic failover to Hyderabad |
| Replication Lag | Continuous monitoring and alerting |
| Database Failure | Aurora Global Database promotion |
| Cache Failure | Redis Global Datastore promotion |
| Kafka Failure | MSK Replicator |
| DNS Failure | Route53 health checks |

---

# Final Recommendation

Implement an **Active-Passive Multi-Region Disaster Recovery Architecture** with:

- Mumbai (Primary)
- Hyderabad (Disaster Recovery)
- Route53 Failover Routing
- Aurora Global Database
- DynamoDB Global Tables
- Redis Global Datastore
- Amazon MSK Replication
- Amazon EKS in both regions
- Terraform-managed infrastructure
- Automated disaster recovery and monitoring

This architecture provides the best balance between availability, operational simplicity, regulatory compliance, and cost while satisfying all project objectives.
