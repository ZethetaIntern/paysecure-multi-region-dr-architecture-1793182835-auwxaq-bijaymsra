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

./scripts/destroy.sh <environment>

Available environments:

  dev
  prod

Examples:

./scripts/destroy.sh dev
./scripts/destroy.sh prod
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
# Production Safety Checks
###############################################

if [[ "${ENVIRONMENT}" == "prod" ]]; then

    echo
    warn "WARNING: You are about to destroy the PRODUCTION environment."
    warn "This action is IRREVERSIBLE."
    echo

    read -rp "Type 'DESTROY-PROD' to continue: " CONFIRM

    if [[ "${CONFIRM}" != "DESTROY-PROD" ]]; then
        error "Confirmation failed."
        exit 1
    fi

    read -rp "Type 'YES' to permanently destroy production: " FINAL_CONFIRM

    if [[ "${FINAL_CONFIRM}" != "YES" ]]; then
        error "Production destruction cancelled."
        exit 1
    fi

fi

###############################################
# Terraform Destroy
###############################################

cd "${ENV_DIR}"

info "Terraform Initialization..."

terraform init

info "Terraform Validation..."

terraform validate

echo
warn "Environment : ${ENVIRONMENT}"
warn "Terraform Destroy will permanently remove infrastructure."
echo

read -rp "Continue with terraform destroy? (yes/no): " APPROVAL

if [[ "${APPROVAL}" != "yes" ]]; then
    warn "Destroy operation cancelled."
    exit 0
fi

info "Destroying infrastructure..."

terraform destroy -auto-approve

success "Infrastructure destroyed successfully."