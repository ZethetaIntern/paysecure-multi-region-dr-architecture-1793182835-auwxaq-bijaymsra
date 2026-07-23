#########################################
# Cluster
#########################################

output "cluster_arn" {
  description = "Amazon MSK Cluster ARN"
  value       = aws_msk_cluster.this.arn
}

output "cluster_name" {
  description = "Amazon MSK Cluster Name"
  value       = aws_msk_cluster.this.cluster_name
}

output "cluster_uuid" {
  description = "Amazon MSK Cluster UUID"
  value       = aws_msk_cluster.this.cluster_uuid
}

output "current_version" {
  description = "Current Cluster Version"
  value       = aws_msk_cluster.this.current_version
}

#########################################
# Bootstrap Brokers
#########################################

output "bootstrap_brokers" {
  description = "Bootstrap Brokers"
  value       = aws_msk_cluster.this.bootstrap_brokers
}

output "bootstrap_brokers_tls" {
  description = "TLS Bootstrap Brokers"
  value       = aws_msk_cluster.this.bootstrap_brokers_tls
}

output "bootstrap_brokers_sasl_iam" {
  description = "SASL IAM Bootstrap Brokers"
  value       = aws_msk_cluster.this.bootstrap_brokers_sasl_iam
}

output "bootstrap_brokers_sasl_scram" {
  description = "SASL SCRAM Bootstrap Brokers"
  value       = aws_msk_cluster.this.bootstrap_brokers_sasl_scram
}

#########################################
# ZooKeeper
#########################################

output "zookeeper_connect_string" {
  description = "ZooKeeper Connect String"
  value       = aws_msk_cluster.this.zookeeper_connect_string
}

output "zookeeper_connect_string_tls" {
  description = "ZooKeeper TLS Connect String"
  value       = aws_msk_cluster.this.zookeeper_connect_string_tls
}

#########################################
# Logging
#########################################

output "cloudwatch_log_group_name" {
  description = "CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.this.name
}

output "cloudwatch_log_group_arn" {
  description = "CloudWatch Log Group ARN"
  value       = aws_cloudwatch_log_group.this.arn
}

#########################################
# Configuration
#########################################

output "configuration_arn" {
  description = "MSK Configuration ARN"
  value       = aws_msk_configuration.this.arn
}

output "configuration_revision" {
  description = "MSK Configuration Revision"
  value       = aws_msk_configuration.this.latest_revision
}
