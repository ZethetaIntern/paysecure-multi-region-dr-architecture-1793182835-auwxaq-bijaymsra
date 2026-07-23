terraform {

  backend "s3" {

    bucket         = "paysecure-terraform-state-prod"

    key            = "multi-region-dr/terraform.tfstate"

    region         = "ap-south-1"

    dynamodb_table = "terraform-state-lock"

    encrypt        = true

    use_lockfile   = true
  }

}
