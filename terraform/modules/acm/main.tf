#########################################
# ACM Certificate
#########################################

resource "aws_acm_certificate" "this" {

  domain_name = var.domain_name

  validation_method = var.validation_method

  subject_alternative_names = var.subject_alternative_names

  key_algorithm = var.key_algorithm

  options {

    certificate_transparency_logging_preference =
      var.certificate_transparency_logging_preference ? "ENABLED" : "DISABLED"

  }

  lifecycle {

    create_before_destroy = true

  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-certificate"
    }
  )
}

#########################################
# DNS Validation Records
#########################################

resource "aws_route53_record" "validation" {

  for_each = var.create_dns_validation_records ? {

    for dvo in aws_acm_certificate.this.domain_validation_options :

    dvo.domain_name => {

      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value

    }

  } : {}

  zone_id = var.hosted_zone_id

  name = each.value.name

  type = each.value.type

  ttl = 60

  records = [
    each.value.record
  ]

  allow_overwrite = true
}

#########################################
# Certificate Validation
#########################################

resource "aws_acm_certificate_validation" "this" {

  count = var.wait_for_validation ? 1 : 0

  certificate_arn = aws_acm_certificate.this.arn

  validation_record_fqdns = [
    for record in aws_route53_record.validation :
    record.fqdn
  ]
}
