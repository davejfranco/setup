#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing Stow..."

if command -v stow &>/dev/null; then
  print_warning "Stow is already installed"
  return 0
fi

$SUDO apt-get update
$SUDO apt-get install -y stow

print_info "Stow installed successfully!"
