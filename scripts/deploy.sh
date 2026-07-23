#!/usr/bin/env bash

set -euo pipefail

###############################################
# Configuration
###############################################

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TF_ROOT="${ROOT_DIR}/terraform"

###############################################
# Colors
###############################################

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
NC="\033[0m"

###############################################
# Logging
###############################################

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

###############################################
# Usage
###############################################

usage() {
cat <<EOF
Usage:

./scripts/deploy.sh <environment>

Available environments:

  dev
  prod

Example:

./scripts/deploy.sh dev
./scripts/deploy.sh prod
EOF
}

###############################################
# Validate Input
###############################################

if [[ $# -ne 1 ]]; then
    usage
    exit 1
fi

ENVIRONMENT="$1"

case "${ENVIRONMENT}" in
    dev|prod)
        ;;
    *)
        error "Invalid environment: ${ENVIRONMENT}"
        usage
        exit 1
        ;;
esac

ENV_DIR="${TF_ROOT}/environments/${ENVIRONMENT}"

if [[ ! -d "${ENV_DIR}" ]]; then
    error "Environment directory not found."
    exit 1
fi

###############################################
# Terraform
###############################################

cd "${ENV_DIR}"

info "Terraform Format Check..."
terraform fmt -recursive

info "Terraform Initialization..."
terraform init

info "Terraform Validation..."
terraform validate

info "Terraform Planning..."
terraform plan -out=tfplan

echo
warn "Environment : ${ENVIRONMENT}"
warn "Review the execution plan carefully."
echo

read -rp "Do you want to continue with apply? (yes/no): " APPROVAL

if [[ "${APPROVAL}" != "yes" ]]; then
    warn "Deployment cancelled."
    exit 0
fi

info "Applying Terraform..."

terraform apply tfplan

success "Deployment completed successfully."

info "Cleaning temporary files..."

rm -f tfplan

success "Done."