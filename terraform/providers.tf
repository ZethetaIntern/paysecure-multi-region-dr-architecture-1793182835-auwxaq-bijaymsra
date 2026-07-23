#########################################
# Default AWS Provider (Primary Region)
#########################################

provider "aws" {
  region = var.primary_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "Cloud Engineering"
      Repository  = "paysecure-multi-region-dr-architecture"
    }
  }
}

#########################################
# Disaster Recovery Provider
#########################################

provider "aws" {
  alias  = "dr"
  region = var.dr_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "Cloud Engineering"
      Repository  = "paysecure-multi-region-dr-architecture"
    }
  }
}

#########################################
# Kubernetes Provider (Primary)
#########################################

provider "kubernetes" {
  host                   = module.primary_eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.primary_eks.cluster_ca_certificate)
  token                  = data.aws_eks_cluster_auth.primary.token
}

#########################################
# Kubernetes Provider (DR)
#########################################

provider "kubernetes" {
  alias                  = "dr"
  host                   = module.dr_eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.dr_eks.cluster_ca_certificate)
  token                  = data.aws_eks_cluster_auth.dr.token
}

#########################################
# Helm Provider (Primary)
#########################################

provider "helm" {
  kubernetes {
    host                   = module.primary_eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.primary_eks.cluster_ca_certificate)
    token                  = data.aws_eks_cluster_auth.primary.token
  }
}

#########################################
# Helm Provider (DR)
#########################################

provider "helm" {
  alias = "dr"

  kubernetes {
    host                   = module.dr_eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.dr_eks.cluster_ca_certificate)
    token                  = data.aws_eks_cluster_auth.dr.token
  }
}
