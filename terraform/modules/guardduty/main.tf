#########################################
# GuardDuty Detector
#########################################

resource "aws_guardduty_detector" "this" {

  enable = var.enable_detector

  finding_publishing_frequency =
    var.finding_publishing_frequency

  #######################################
  # Protection Features
  #######################################

  datasources {

    s3_logs {

      enable = var.enable_s3_protection

    }

    kubernetes {

      audit_logs {

        enable = var.enable_eks_audit_logs

      }

    }

    malware_protection {

      scan_ec2_instance_with_findings {

        ebs_volumes {

          enable = var.enable_malware_protection

        }

      }

    }

  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-guardduty"
    }
  )

}

#########################################
# Publishing Destination
#########################################

resource "aws_guardduty_publishing_destination" "this" {

  count = var.enable_publishing_destination ? 1 : 0

  detector_id = aws_guardduty_detector.this.id

  destination_arn = var.destination_arn

  kms_key_arn = var.kms_key_arn

}
