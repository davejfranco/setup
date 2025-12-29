#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing kubectx..."

if command -v kubectx &>/dev/null; then
  print_warning "Kubectx is already installed"
  return 0
fi

$SUDO apt-get update
$SUDO apt-get install -y kubectx

print_info "Kubectx installed successfully!"
