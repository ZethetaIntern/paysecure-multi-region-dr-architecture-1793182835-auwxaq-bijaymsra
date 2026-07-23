#########################################
# VPC
#########################################

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "vpc_arn" {
  description = "VPC ARN"
  value       = aws_vpc.this.arn
}

output "vpc_cidr_block" {
  description = "VPC CIDR Block"
  value       = aws_vpc.this.cidr_block
}

#########################################
# Internet Gateway
#########################################

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.this.id
}

#########################################
# Public Subnets
#########################################

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = aws_subnet.public[*].id
}

output "public_subnet_arns" {
  description = "Public Subnet ARNs"
  value       = aws_subnet.public[*].arn
}

#########################################
# Private Application Subnets
#########################################

output "private_app_subnet_ids" {
  description = "Private Application Subnet IDs"
  value       = aws_subnet.private_app[*].id
}

output "private_app_subnet_arns" {
  description = "Private Application Subnet ARNs"
  value       = aws_subnet.private_app[*].arn
}

#########################################
# Private Database Subnets
#########################################

output "private_db_subnet_ids" {
  description = "Private Database Subnet IDs"
  value       = aws_subnet.private_db[*].id
}

output "private_db_subnet_arns" {
  description = "Private Database Subnet ARNs"
  value       = aws_subnet.private_db[*].arn
}

#########################################
# NAT Gateways
#########################################

output "nat_gateway_ids" {
  description = "NAT Gateway IDs"
  value       = aws_nat_gateway.this[*].id
}

output "nat_gateway_public_ips" {
  description = "NAT Gateway Public IPs"
  value       = aws_eip.nat[*].public_ip
}

#########################################
# Route Tables
#########################################

output "public_route_table_id" {
  description = "Public Route Table ID"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "Private Route Table IDs"
  value       = aws_route_table.private[*].id
}

#########################################
# Database Subnet Group
#########################################

output "db_subnet_group_name" {
  description = "Database Subnet Group Name"
  value       = aws_db_subnet_group.this.name
}

output "db_subnet_group_id" {
  description = "Database Subnet Group ID"
  value       = aws_db_subnet_group.this.id
}

#########################################
# Flow Logs
#########################################

output "flow_log_id" {
  description = "VPC Flow Log ID"
  value       = aws_flow_log.this.id
}

output "flow_log_group_name" {
  description = "CloudWatch Log Group for Flow Logs"
  value       = aws_cloudwatch_log_group.flow_logs.name
}

output "flow_log_role_arn" {
  description = "IAM Role ARN for VPC Flow Logs"
  value       = aws_iam_role.flow_logs.arn
}
