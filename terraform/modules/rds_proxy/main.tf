#########################################
# RDS Proxy
#########################################

resource "aws_db_proxy" "this" {

  name = var.proxy_name

  engine_family = var.engine_family

  role_arn = var.iam_role_arn

  vpc_subnet_ids = var.vpc_subnet_ids

  vpc_security_group_ids = var.security_group_ids

  require_tls = var.require_tls

  idle_client_timeout = var.idle_client_timeout

  debug_logging = var.debug_logging

  #######################################
  # Authentication
  #######################################

  auth {

    auth_scheme = "SECRETS"

    iam_auth = var.iam_auth

    secret_arn = var.secret_arn

  }

  tags = merge(
    var.tags,
    {
      Name = var.proxy_name
    }
  )
}

#########################################
# Default Target Group
#########################################

resource "aws_db_proxy_default_target_group" "this" {

  db_proxy_name = aws_db_proxy.this.name

  connection_pool_config {

    max_connections_percent = var.max_connections_percent

    max_idle_connections_percent = var.max_idle_connections_percent

    connection_borrow_timeout = var.connection_borrow_timeout

  }

}

#########################################
# Register Aurora Cluster
#########################################

resource "aws_db_proxy_target" "this" {

  db_proxy_name = aws_db_proxy.this.name

  target_group_name =
    aws_db_proxy_default_target_group.this.name

  db_cluster_identifier = var.db_cluster_identifier

}
