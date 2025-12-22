#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing prerequisites"

$SUDO apt-get update
$SUDO apt-get install -y unzip \
  gnupg \
  ca-certificates \
  curl \
  lsb-release \
  python3-pip \
  htop

print_info "Pre-requisites installed successfully!"
