#########################################
# Primary Replication Group
#########################################

output "primary_replication_group_id" {
  description = "Primary Replication Group ID"
  value       = aws_elasticache_replication_group.primary.id
}

output "primary_replication_group_arn" {
  description = "Primary Replication Group ARN"
  value       = aws_elasticache_replication_group.primary.arn
}

output "primary_configuration_endpoint" {
  description = "Primary Configuration Endpoint"
  value       = aws_elasticache_replication_group.primary.configuration_endpoint_address
}

output "primary_primary_endpoint" {
  description = "Primary Endpoint"
  value       = aws_elasticache_replication_group.primary.primary_endpoint_address
}

output "primary_reader_endpoint" {
  description = "Primary Reader Endpoint"
  value       = aws_elasticache_replication_group.primary.reader_endpoint_address
}

#########################################
# Global Datastore
#########################################

output "global_replication_group_id" {
  description = "Global Replication Group ID"
  value       = aws_elasticache_global_replication_group.this.global_replication_group_id
}

output "global_replication_group_arn" {
  description = "Global Replication Group ARN"
  value       = aws_elasticache_global_replication_group.this.arn
}

#########################################
# Secondary Replication Group
#########################################

output "secondary_replication_group_id" {
  description = "Secondary Replication Group ID"
  value       = aws_elasticache_replication_group.secondary.id
}

output "secondary_replication_group_arn" {
  description = "Secondary Replication Group ARN"
  value       = aws_elasticache_replication_group.secondary.arn
}

output "secondary_configuration_endpoint" {
  description = "Secondary Configuration Endpoint"
  value       = aws_elasticache_replication_group.secondary.configuration_endpoint_address
}

#########################################
# Subnet Groups
#########################################

output "primary_subnet_group_name" {
  description = "Primary Redis Subnet Group"
  value       = aws_elasticache_subnet_group.primary.name
}

output "dr_subnet_group_name" {
  description = "DR Redis Subnet Group"
  value       = aws_elasticache_subnet_group.dr.name
}

#########################################
# Configuration
#########################################

output "engine_version" {
  description = "Redis Engine Version"
  value       = aws_elasticache_replication_group.primary.engine_version_actual
}

output "node_type" {
  description = "Redis Node Type"
  value       = aws_elasticache_replication_group.primary.node_type
}

output "port" {
  description = "Redis Port"
  value       = aws_elasticache_replication_group.primary.port
}
