#########################################
# DB Subnet Groups
#########################################

resource "aws_db_subnet_group" "primary" {

  name = "${var.project_name}-primary-db-subnet-group"

  subnet_ids = var.primary_subnets

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-primary-db-subnet-group"
    }
  )
}

resource "aws_db_subnet_group" "dr" {

  provider = aws.dr

  name = "${var.project_name}-dr-db-subnet-group"

  subnet_ids = var.dr_subnets

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-dr-db-subnet-group"
    }
  )
}

#########################################
# Cluster Parameter Group
#########################################

resource "aws_rds_cluster_parameter_group" "this" {

  name   = "${var.project_name}-cluster-pg"
  family = "aurora-postgresql16"

  parameter {
    name  = "log_statement"
    value = "ddl"
  }

  parameter {
    name  = "log_connections"
    value = "1"
  }

  tags = var.tags
}

#########################################
# DB Parameter Group
#########################################

resource "aws_db_parameter_group" "this" {

  name   = "${var.project_name}-db-pg"
  family = "aurora-postgresql16"

  parameter {
    name  = "log_min_duration_statement"
    value = "1000"
  }

  tags = var.tags
}

#########################################
# Aurora Global Cluster
#########################################

resource "aws_rds_global_cluster" "this" {

  global_cluster_identifier = "${var.project_name}-global"

  engine         = var.engine
  engine_version = var.engine_version

  storage_encrypted = true

  deletion_protection = var.deletion_protection

  tags = var.tags
}

#########################################
# Primary Cluster
#########################################

resource "aws_rds_cluster" "primary" {

  cluster_identifier = "${var.project_name}-primary"

  engine         = var.engine
  engine_version = var.engine_version

  global_cluster_identifier = aws_rds_global_cluster.this.id

  database_name   = var.database_name
  master_username = var.master_username
  master_password = var.master_password

  db_subnet_group_name = aws_db_subnet_group.primary.name

  vpc_security_group_ids = [
    var.primary_security_group_id
  ]

  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.this.name

  storage_encrypted = var.storage_encrypted

  kms_key_id = var.kms_key_arn

  backup_retention_period = var.backup_retention_period

  preferred_backup_window = var.preferred_backup_window

  preferred_maintenance_window = var.preferred_maintenance_window

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  deletion_protection = var.deletion_protection

  apply_immediately = var.apply_immediately

  tags = var.tags
}

#########################################
# Primary Instance
#########################################

resource "aws_rds_cluster_instance" "primary" {

  identifier = "${var.project_name}-primary-1"

  cluster_identifier = aws_rds_cluster.primary.id

  instance_class = var.instance_class

  engine         = var.engine
  engine_version = var.engine_version

  db_parameter_group_name = aws_db_parameter_group.this.name

  performance_insights_enabled = var.performance_insights_enabled

  monitoring_interval = var.monitoring_interval

  auto_minor_version_upgrade = true

  publicly_accessible = false

  tags = var.tags
}

#########################################
# Secondary Cluster
#########################################

resource "aws_rds_cluster" "secondary" {

  provider = aws.dr

  cluster_identifier = "${var.project_name}-dr"

  engine         = var.engine
  engine_version = var.engine_version

  global_cluster_identifier = aws_rds_global_cluster.this.id

  db_subnet_group_name = aws_db_subnet_group.dr.name

  vpc_security_group_ids = [
    var.dr_security_group_id
  ]

  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.this.name

  storage_encrypted = var.storage_encrypted

  kms_key_id = var.kms_key_arn

  deletion_protection = var.deletion_protection

  apply_immediately = var.apply_immediately

  tags = var.tags
}

#########################################
# Secondary Instance
#########################################

resource "aws_rds_cluster_instance" "secondary" {

  provider = aws.dr

  identifier = "${var.project_name}-dr-1"

  cluster_identifier = aws_rds_cluster.secondary.id

  instance_class = var.instance_class

  engine         = var.engine
  engine_version = var.engine_version

  db_parameter_group_name = aws_db_parameter_group.this.name

  performance_insights_enabled = var.performance_insights_enabled

  monitoring_interval = var.monitoring_interval

  auto_minor_version_upgrade = true

  publicly_accessible = false

  tags = var.tags
}
