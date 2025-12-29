#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing k9s..."

if command -v k9s &>/dev/null; then
  print_warning "k9s is already installed"
  k9s version 2>/dev/null || true
  return 0
fi

# For Arch, k9s is in pacman (installed in base packages)
# For Debian, we download and install the .deb package
if command -v apt-get &>/dev/null; then
  curl -L https://github.com/derailed/k9s/releases/download/v0.32.7/k9s_linux_amd64.deb \
    -o /tmp/k9s_linux_amd64.deb
  
  $SUDO dpkg -i /tmp/k9s_linux_amd64.deb
  
  rm /tmp/k9s_linux_amd64.deb
fi

print_info "k9s installed successfully!"
k9s version 2>/dev/null || true
