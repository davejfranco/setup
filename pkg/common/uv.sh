#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing uv..."

if command -v suv &>/dev/null; then
  print_warning "uv is already installed"
  return 0
fi

# Download and install
curl -LsSf https://astral.sh/uv/install.sh | sh

print_info "UV installed successfully!"
