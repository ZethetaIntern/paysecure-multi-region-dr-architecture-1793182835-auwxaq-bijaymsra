#########################################
# Global Cluster
#########################################

output "global_cluster_id" {
  description = "Aurora Global Cluster ID"
  value       = aws_rds_global_cluster.this.id
}

output "global_cluster_arn" {
  description = "Aurora Global Cluster ARN"
  value       = aws_rds_global_cluster.this.arn
}

#########################################
# Primary Cluster
#########################################

output "primary_cluster_id" {
  description = "Primary Aurora Cluster ID"
  value       = aws_rds_cluster.primary.id
}

output "primary_cluster_arn" {
  description = "Primary Aurora Cluster ARN"
  value       = aws_rds_cluster.primary.arn
}

output "primary_endpoint" {
  description = "Primary Writer Endpoint"
  value       = aws_rds_cluster.primary.endpoint
}

output "reader_endpoint" {
  description = "Primary Reader Endpoint"
  value       = aws_rds_cluster.primary.reader_endpoint
}

output "primary_cluster_resource_id" {
  description = "Primary Cluster Resource ID"
  value       = aws_rds_cluster.primary.cluster_resource_id
}

#########################################
# Secondary Cluster
#########################################

output "secondary_cluster_id" {
  description = "Secondary Aurora Cluster ID"
  value       = aws_rds_cluster.secondary.id
}

output "secondary_cluster_arn" {
  description = "Secondary Aurora Cluster ARN"
  value       = aws_rds_cluster.secondary.arn
}

output "secondary_reader_endpoint" {
  description = "Secondary Reader Endpoint"
  value       = aws_rds_cluster.secondary.reader_endpoint
}

output "secondary_cluster_resource_id" {
  description = "Secondary Cluster Resource ID"
  value       = aws_rds_cluster.secondary.cluster_resource_id
}

#########################################
# Database Instances
#########################################

output "primary_instance_id" {
  description = "Primary Aurora Instance ID"
  value       = aws_rds_cluster_instance.primary.id
}

output "primary_instance_arn" {
  description = "Primary Aurora Instance ARN"
  value       = aws_rds_cluster_instance.primary.arn
}

output "secondary_instance_id" {
  description = "Secondary Aurora Instance ID"
  value       = aws_rds_cluster_instance.secondary.id
}

output "secondary_instance_arn" {
  description = "Secondary Aurora Instance ARN"
  value       = aws_rds_cluster_instance.secondary.arn
}

#########################################
# Subnet Groups
#########################################

output "primary_db_subnet_group" {
  description = "Primary DB Subnet Group"
  value       = aws_db_subnet_group.primary.name
}

output "dr_db_subnet_group" {
  description = "DR DB Subnet Group"
  value       = aws_db_subnet_group.dr.name
}

#########################################
# Parameter Groups
#########################################

output "cluster_parameter_group" {
  description = "Cluster Parameter Group"
  value       = aws_rds_cluster_parameter_group.this.name
}

output "db_parameter_group" {
  description = "Database Parameter Group"
  value       = aws_db_parameter_group.this.name
}
