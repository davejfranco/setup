#!/bin/bash

# Omarchy (Arch) package installation script
# Uses the new package-list based installation system

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/util/util.sh"

print_info "Starting Omarchy system setup..."

check_sudo

# Check if running on Arch-based system
if ! command -v pacman &>/dev/null; then
  print_error "This system does not appear to be Arch-based"
  exit 1
fi

# Install packages from package list
print_info "Installing packages from omarchy-base.packages..."
source "$PROJECT_ROOT/pkg/install-pacman.sh" "$PROJECT_ROOT/install/omarchy-base.packages"

echo ""
print_info "═══════════════════════════════════════════════════════════"
print_info "Omarchy setup completed successfully!"
print_info "═══════════════════════════════════════════════════════════"
print_info "You may need to log out and back in for some changes to take effect."
print_info "(Especially for Docker group permissions and shell changes)"
