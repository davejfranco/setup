#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing k9s..."

if command -v k9s &>/dev/null; then
  print_warning "K9s is already installed"
  return 0
fi

curl -L https://github.com/derailed/k9s/releases/download/v0.50.16/k9s_linux_amd64.deb \
  -o /tmp/k9s_linux_amd64.deb

$SUDO dpkg -i /tmp/k9s_linux_amd654.deb

print_info "K9s installed successfully!"

