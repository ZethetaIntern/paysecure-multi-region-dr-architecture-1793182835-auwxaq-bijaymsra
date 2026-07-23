#########################################
# Route53 Hosted Zone
#########################################

resource "aws_route53_zone" "this" {

  name = var.hosted_zone_name

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-hosted-zone"
    }
  )
}

#########################################
# Primary Health Check
#########################################

resource "aws_route53_health_check" "primary" {

  fqdn              = "${var.application_subdomain}.${var.hosted_zone_name}"
  port              = var.health_check_port
  type              = var.health_check_protocol
  resource_path     = var.health_check_path
  request_interval  = var.request_interval
  failure_threshold = var.failure_threshold

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-primary-health-check"
    }
  )
}

#########################################
# Primary Failover Record
#########################################

resource "aws_route53_record" "primary" {

  zone_id = aws_route53_zone.this.zone_id

  name = "${var.application_subdomain}.${var.hosted_zone_name}"

  type = "A"

  set_identifier = "primary"

  failover_routing_policy {

    type = "PRIMARY"

  }

  health_check_id = aws_route53_health_check.primary.id

  alias {

    name                   = var.primary_alb_dns_name
    zone_id                = var.primary_alb_zone_id
    evaluate_target_health = true

  }
}

#########################################
# Secondary Failover Record
#########################################

resource "aws_route53_record" "secondary" {

  zone_id = aws_route53_zone.this.zone_id

  name = "${var.application_subdomain}.${var.hosted_zone_name}"

  type = "A"

  set_identifier = "secondary"

  failover_routing_policy {

    type = "SECONDARY"

  }

  alias {

    name                   = var.dr_alb_dns_name
    zone_id                = var.dr_alb_zone_id
    evaluate_target_health = true

  }
}
