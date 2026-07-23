#########################################
# RDS Proxy
#########################################

output "proxy_id" {
  description = "Amazon RDS Proxy ID"
  value       = aws_db_proxy.this.id
}

output "proxy_name" {
  description = "Amazon RDS Proxy Name"
  value       = aws_db_proxy.this.name
}

output "proxy_arn" {
  description = "Amazon RDS Proxy ARN"
  value       = aws_db_proxy.this.arn
}

output "proxy_endpoint" {
  description = "Amazon RDS Proxy Endpoint"
  value       = aws_db_proxy.this.endpoint
}

#########################################
# Target Group
#########################################

output "target_group_name" {
  description = "Default Target Group Name"
  value       = aws_db_proxy_default_target_group.this.name
}

output "target_group_arn" {
  description = "Default Target Group ARN"
  value       = aws_db_proxy_default_target_group.this.arn
}

#########################################
# Target Database
#########################################

output "registered_db_cluster" {
  description = "Registered Aurora Cluster Identifier"
  value       = var.db_cluster_identifier
}

#########################################
# Authentication
#########################################

output "iam_authentication_mode" {
  description = "IAM Authentication Mode"
  value       = var.iam_auth
}

output "tls_required" {
  description = "Require TLS Connections"
  value       = var.require_tls
}

#########################################
# Connection Pool
#########################################

output "connection_pool_configuration" {
  description = "Connection Pool Configuration"

  value = {
    max_connections_percent      = var.max_connections_percent
    max_idle_connections_percent = var.max_idle_connections_percent
    connection_borrow_timeout    = var.connection_borrow_timeout
    idle_client_timeout          = var.idle_client_timeout
  }
}

#########################################
# Module Summary
#########################################

output "rds_proxy_summary" {
  description = "Amazon RDS Proxy Module Summary"

  value = {
    proxy_name          = aws_db_proxy.this.name
    endpoint            = aws_db_proxy.this.endpoint
    engine_family       = var.engine_family
    registered_cluster  = var.db_cluster_identifier
    require_tls         = var.require_tls
    iam_auth            = var.iam_auth
    debug_logging       = var.debug_logging
    idle_timeout        = var.idle_client_timeout
  }
}
