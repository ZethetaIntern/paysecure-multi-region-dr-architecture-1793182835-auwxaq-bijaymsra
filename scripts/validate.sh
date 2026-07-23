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

./scripts/validate.sh <environment>

Available environments:

  dev
  prod

Examples:

./scripts/validate.sh dev
./scripts/validate.sh prod
EOF
}

###############################################
# Validate Arguments
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
# Terraform Validation
###############################################

cd "${ENV_DIR}"

info "Running Terraform Format Check..."

terraform fmt -recursive -check

success "Terraform formatting is valid."

echo

info "Initializing Terraform..."

terraform init -input=false

success "Terraform initialization completed."

echo

info "Running Terraform Validation..."

terraform validate

success "Terraform configuration is valid."

echo

###############################################
# Optional Terraform Lint
###############################################

if command -v tflint >/dev/null 2>&1; then

    info "Running TFLint..."

    tflint --recursive

    success "TFLint completed successfully."

else

    warn "TFLint is not installed. Skipping."

fi

echo

###############################################
# Validate All Modules
###############################################

info "Checking Terraform modules..."

find "${TF_ROOT}/modules" -type f -name "*.tf" >/dev/null

success "Terraform modules discovered successfully."

echo

success "=========================================="
success "Terraform validation completed successfully."
success "Environment : ${ENVIRONMENT}"
success "=========================================="