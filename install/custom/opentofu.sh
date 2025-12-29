#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing OpenTofu..."

if command -v tofu &>/dev/null; then
  print_warning "OpenTofu is already installed"
  tofu --version
  return 0
fi

# OpenTofu provides a standalone installer that works on both Debian and Arch
# Download opentofu install script
curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh \
  -o /tmp/install-opentofu.sh

# Make script executable
chmod +x /tmp/install-opentofu.sh

# Execute install script
/tmp/install-opentofu.sh --install-method standalone

# Remove install script
rm /tmp/install-opentofu.sh

print_info "OpenTofu installed successfully!"
tofu --version
