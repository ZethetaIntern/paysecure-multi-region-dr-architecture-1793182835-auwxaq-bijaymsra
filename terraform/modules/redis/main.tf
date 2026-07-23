#########################################
# Primary Subnet Group
#########################################

resource "aws_elasticache_subnet_group" "primary" {

  name = "${var.project_name}-redis-primary"

  subnet_ids = var.primary_subnets

  description = "Primary Redis Subnet Group"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-redis-primary"
    }
  )
}

#########################################
# DR Subnet Group
#########################################

resource "aws_elasticache_subnet_group" "dr" {

  provider = aws.dr

  name = "${var.project_name}-redis-dr"

  subnet_ids = var.dr_subnets

  description = "DR Redis Subnet Group"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-redis-dr"
    }
  )
}

#########################################
# Primary Replication Group
#########################################

resource "aws_elasticache_replication_group" "primary" {

  replication_group_id = var.replication_group_id

  description = var.description

  engine         = var.engine
  engine_version = var.engine_version

  node_type = var.node_type

  port = var.port

  subnet_group_name = aws_elasticache_subnet_group.primary.name

  security_group_ids = [
    var.primary_security_group_id
  ]

  num_cache_clusters = var.num_cache_clusters

  automatic_failover_enabled = var.automatic_failover_enabled

  multi_az_enabled = var.multi_az_enabled

  at_rest_encryption_enabled = var.at_rest_encryption_enabled

  transit_encryption_enabled = var.transit_encryption_enabled

  kms_key_id = var.kms_key_arn

  auth_token = var.auth_token

  snapshot_retention_limit = var.snapshot_retention_limit

  snapshot_window = var.snapshot_window

  maintenance_window = var.maintenance_window

  apply_immediately = false

  auto_minor_version_upgrade = true

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-redis-primary"
    }
  )
}

#########################################
# Global Replication Group
#########################################

resource "aws_elasticache_global_replication_group" "this" {

  global_replication_group_id_suffix = var.project_name

  primary_replication_group_id = aws_elasticache_replication_group.primary.id
}

#########################################
# Secondary Replication Group
#########################################

resource "aws_elasticache_replication_group" "secondary" {

  provider = aws.dr

  replication_group_id = "${var.replication_group_id}-dr"

  description = "Disaster Recovery Redis Cluster"

  global_replication_group_id =
    aws_elasticache_global_replication_group.this.global_replication_group_id

  subnet_group_name = aws_elasticache_subnet_group.dr.name

  security_group_ids = [
    var.dr_security_group_id
  ]

  depends_on = [
    aws_elasticache_global_replication_group.this
  ]

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-redis-dr"
    }
  )
}
