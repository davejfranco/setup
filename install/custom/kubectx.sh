#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing kubectx..."

if command -v kubectx &>/dev/null; then
  print_warning "kubectx is already installed"
  return 0
fi

# Install based on package manager
if command -v apt-get &>/dev/null; then
  $SUDO apt-get update
  $SUDO apt-get install -y kubectx
elif command -v pacman &>/dev/null; then
  $SUDO pacman -S --needed --noconfirm kubectx
fi

print_info "kubectx installed successfully!"
