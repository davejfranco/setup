#!/usr/bin/env bash

source ../../util/util.sh

print_info "Installing OpenTofu..."

if command -v tofu &>/dev/null; then
  print_warning "OpenTofu is already installed"
  tofu --version
  return 0
fi

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
