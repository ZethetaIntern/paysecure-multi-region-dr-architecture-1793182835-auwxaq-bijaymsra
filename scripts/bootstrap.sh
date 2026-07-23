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
# Dependency Check
###############################################

check_command() {

    local cmd="$1"

    if command -v "${cmd}" >/dev/null 2>&1; then
        success "${cmd} is installed."
    else
        error "${cmd} is NOT installed."
        return 1
    fi

}

###############################################
# Banner
###############################################

echo
info "=============================================="
info " PaySecure Infrastructure Bootstrap"
info "=============================================="
echo

###############################################
# Required Tools
###############################################

FAILED=0

for TOOL in git terraform aws kubectl helm; do

    if ! check_command "${TOOL}"; then
        FAILED=1
    fi

done

echo

###############################################
# AWS Authentication
###############################################

info "Checking AWS authentication..."

if aws sts get-caller-identity >/dev/null 2>&1; then
    success "AWS credentials are valid."
else
    error "AWS CLI is not authenticated."
    FAILED=1
fi

echo

###############################################
# Terraform Directory
###############################################

if [[ -d "${TF_ROOT}" ]]; then
    success "Terraform directory found."
else
    error "Terraform directory not found."
    FAILED=1
fi

echo

###############################################
# Backend Configuration
###############################################

info "Backend Configuration"

cat <<EOF

Before deploying infrastructure, ensure that:

1. Remote Terraform backend is configured.
2. S3 bucket for state exists.
3. DynamoDB state locking table exists.
4. AWS credentials are configured.
5. Required IAM permissions are available.

EOF

echo

###############################################
# Kubernetes
###############################################

info "Checking Kubernetes client..."

kubectl version --client >/dev/null 2>&1 \
    && success "kubectl client is working." \
    || warn "kubectl client check failed."

echo

###############################################
# Helm
###############################################

info "Checking Helm..."

helm version >/dev/null 2>&1 \
    && success "Helm is working." \
    || warn "Helm check failed."

echo

###############################################
# Terraform Version
###############################################

info "Terraform Version"

terraform version

echo

###############################################
# Summary
###############################################

if [[ "${FAILED}" -eq 0 ]]; then

    success "======================================"
    success "Bootstrap completed successfully."
    success "Environment is ready."
    success "======================================"

else

    error "======================================"
    error "Bootstrap completed with errors."
    error "Resolve missing prerequisites."
    error "======================================"

    exit 1

fi