#!/usr/bin/env bash

source ../../util/util.sh

print_info "Installing uv..."

if command -v suv &>/dev/null; then
  print_warning "uv is already installed"
  return 0
fi

# Download and install
curl -LsSf https://astral.sh/uv/install.sh | sh

print_info "UV installed successfully!"
