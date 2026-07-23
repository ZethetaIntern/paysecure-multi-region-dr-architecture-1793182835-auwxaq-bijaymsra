#########################################
# Application Load Balancer
#########################################

resource "aws_lb" "this" {

  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  ip_address_type    = var.ip_address_type

  security_groups = var.security_group_ids
  subnets         = var.subnet_ids

  idle_timeout               = var.idle_timeout
  enable_deletion_protection = var.enable_deletion_protection

  access_logs {

    enabled = var.access_logs_enabled
    bucket  = var.access_logs_bucket
    prefix  = var.access_logs_prefix

  }

  tags = merge(
    var.tags,
    {
      Name = var.alb_name
    }
  )
}

#########################################
# Target Group
#########################################

resource "aws_lb_target_group" "this" {

  name        = var.target_group_name
  port        = var.backend_port
  protocol    = var.backend_protocol
  target_type = var.target_type

  vpc_id = var.vpc_id

  health_check {

    enabled = true

    path = var.health_check_path

    protocol = var.backend_protocol

    interval = var.health_check_interval

    timeout = var.health_check_timeout

    healthy_threshold = var.healthy_threshold

    unhealthy_threshold = var.unhealthy_threshold

    matcher = var.success_codes

  }

  tags = merge(
    var.tags,
    {
      Name = var.target_group_name
    }
  )
}

#########################################
# HTTP Listener
#########################################

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.this.arn

  port     = var.http_listener_port
  protocol = "HTTP"

  default_action {

    type = "redirect"

    redirect {

      port = tostring(var.https_listener_port)

      protocol = "HTTPS"

      status_code = "HTTP_301"

    }

  }

}

#########################################
# HTTPS Listener
#########################################

resource "aws_lb_listener" "https" {

  load_balancer_arn = aws_lb.this.arn

  port     = var.https_listener_port
  protocol = "HTTPS"

  ssl_policy = var.ssl_policy

  certificate_arn = var.certificate_arn

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.this.arn

  }

}
