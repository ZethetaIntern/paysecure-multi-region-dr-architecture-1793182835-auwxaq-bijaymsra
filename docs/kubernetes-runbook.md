# Kubernetes Operations Runbook

This runbook defines the operational procedures for managing the Amazon EKS clusters that power the **PaySecure Multi-Region Disaster Recovery Architecture**.

It provides standardized guidance for cluster administration, workload management, upgrades, scaling, troubleshooting, and disaster recovery.

---

# Objectives

The objectives of this runbook are to:

- Maintain cluster availability
- Standardize Kubernetes operations
- Minimize deployment risk
- Ensure workload reliability
- Support disaster recovery
- Improve operational consistency

---

# Cluster Overview

```text
                  Amazon EKS
                      │
        ┌─────────────┴─────────────┐
        ▼                           ▼
 Managed Node Groups         Managed Node Groups
        │                           │
        ▼                           ▼
 Application Pods          Monitoring Stack
        │
        ▼
Ingress → Services → Pods
        │
        ▼
 Aurora / Redis / MSK
```

---

# Daily Operational Checks

Verify:

- Cluster status
- Node health
- Pod health
- Deployment availability
- Ingress status
- HPA status
- Persistent Volumes
- Cluster events

---

# Cluster Health

Verify cluster connectivity:

```bash
kubectl cluster-info
```

Check nodes:

```bash
kubectl get nodes
```

Expected:

- All nodes Ready
- No scheduling issues
- No NotReady nodes

---

# Namespace Administration

List namespaces:

```bash
kubectl get namespaces
```

Verify:

- Application namespace
- Monitoring namespace
- kube-system
- ingress namespace

Ensure no unexpected namespaces exist.

---

# Node Group Management

Monitor:

- Node availability
- CPU utilization
- Memory utilization
- Disk usage
- Scheduling capacity

Useful commands:

```bash
kubectl top nodes

kubectl describe node <node-name>
```

---

# Pod Operations

List pods:

```bash
kubectl get pods -A
```

Investigate unhealthy pods:

```bash
kubectl describe pod <pod-name>

kubectl logs <pod-name>
```

Check for:

- CrashLoopBackOff
- ImagePullBackOff
- Pending
- OOMKilled
- Failed scheduling

---

# Deployment Management

List deployments:

```bash
kubectl get deployments -A
```

View rollout status:

```bash
kubectl rollout status deployment payment-api
```

Restart deployment:

```bash
kubectl rollout restart deployment payment-api
```

Rollback deployment:

```bash
kubectl rollout undo deployment payment-api
```

---

# Service Operations

Verify services:

```bash
kubectl get svc -A
```

Check:

- ClusterIP
- NodePort (if used)
- LoadBalancer
- External IP
- Endpoints

---

# Ingress Management

Verify ingress resources:

```bash
kubectl get ingress -A
```

Confirm:

- Hostnames
- TLS configuration
- Backend services
- Load Balancer health

---

# ConfigMap Operations

List ConfigMaps:

```bash
kubectl get configmaps -A
```

Review configuration changes before applying updates.

Restart workloads if configuration changes require pod reloads.

---

# Secret Management

Verify secrets:

```bash
kubectl get secrets -A
```

Best practices:

- Store secrets securely
- Rotate credentials regularly
- Avoid hardcoding sensitive data
- Integrate with AWS Secrets Manager where appropriate

---

# Horizontal Pod Autoscaler

Check HPA:

```bash
kubectl get hpa
```

Verify:

- Current replicas
- Target utilization
- Scaling events
- Maximum replicas

---

# Cluster Autoscaler

Confirm:

- Nodes scale correctly
- Pending pods trigger scaling
- Idle nodes scale down
- Resource utilization remains balanced

---

# Persistent Storage

Verify Persistent Volumes:

```bash
kubectl get pv

kubectl get pvc -A
```

Confirm:

- Volumes bound
- Storage healthy
- No pending claims

---

# Cluster Upgrade Procedure

Before upgrade:

- Verify backups
- Validate workloads
- Review Kubernetes version compatibility
- Confirm maintenance window

Upgrade sequence:

```text
Control Plane
      │
      ▼
Managed Node Groups
      │
      ▼
Core Add-ons
      │
      ▼
Application Validation
```

After upgrade:

- Validate workloads
- Verify monitoring
- Confirm networking
- Review cluster events

---

# Monitoring

Monitor:

- Node health
- Pod restarts
- Resource utilization
- Deployment status
- API server health
- Scheduler events

Use:

- Prometheus
- Grafana
- CloudWatch

---

# Troubleshooting

## Pod CrashLoopBackOff

Check:

- Logs
- Events
- Resource limits
- Configuration
- Secrets
- Dependencies

---

## Pending Pods

Investigate:

- Available nodes
- Resource requests
- Node selectors
- Taints
- Tolerations

---

## ImagePullBackOff

Verify:

- Image name
- Image registry
- Credentials
- Network connectivity

---

## Node NotReady

Check:

- Kubelet status
- Node resources
- Network connectivity
- Underlying EC2 instance health

---

# Disaster Recovery

During regional recovery:

- Verify EKS cluster
- Restore workloads
- Validate ingress
- Confirm services
- Check DNS
- Validate application functionality

---

# Operational Checklist

Daily:

- [ ] Nodes healthy
- [ ] Pods healthy
- [ ] Deployments available
- [ ] Ingress operational
- [ ] HPA functioning

Weekly:

- [ ] Resource utilization reviewed
- [ ] Cluster events reviewed
- [ ] Capacity evaluated
- [ ] Unused resources identified

Monthly:

- [ ] Cluster upgrades reviewed
- [ ] Backup procedures validated
- [ ] Security review completed
- [ ] Documentation updated

---

# Best Practices

- Use rolling deployments.
- Define resource requests and limits.
- Enable health probes for all workloads.
- Keep Kubernetes versions supported.
- Monitor cluster capacity continuously.
- Test upgrades in non-production first.
- Automate repetitive operational tasks.
- Review RBAC permissions regularly.

---

# Summary

This Kubernetes Operations Runbook provides standardized operational guidance for administering Amazon EKS clusters, managing workloads, performing upgrades, validating application health, troubleshooting failures, and supporting disaster recovery across the PaySecure Multi-Region Disaster Recovery Architecture.