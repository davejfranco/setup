#!/usr/bin/env bash

# Generic Pacman package installer
# Reads package list from a .packages file and installs via pacman
# Supports custom installation handlers for complex packages

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/util/util.sh"

PACKAGE_FILE="$1"

if [ ! -f "$PACKAGE_FILE" ]; then
  print_error "Package file not found: $PACKAGE_FILE"
  exit 1
fi

print_info "Reading package list from: $PACKAGE_FILE"

# Read standard packages (skip comments, blanks, and CUSTOM entries)
mapfile -t packages < <(grep -v '^#' "$PACKAGE_FILE" | grep -v '^$' | grep -v '^CUSTOM:')

# Read custom packages
mapfile -t custom < <(grep '^CUSTOM:' "$PACKAGE_FILE" | sed 's/^CUSTOM://')

# Install standard packages via pacman
if [ ${#packages[@]} -gt 0 ]; then
  print_info "Installing ${#packages[@]} standard packages via pacman..."
  echo ""

  $SUDO pacman -S --noconfirm --needed "${packages[@]}"

  echo ""
  print_info "Standard packages installed successfully!"
fi

# Install custom packages
if [ ${#custom[@]} -gt 0 ]; then
  print_info "Installing ${#custom[@]} custom packages..."
  echo ""

  for pkg in "${custom[@]}"; do
    if [ -f "$PROJECT_ROOT/install/custom/$pkg.sh" ]; then
      print_info "Installing custom package: $pkg"
      source "$PROJECT_ROOT/install/custom/$pkg.sh"
      echo ""
    else
      print_warning "Custom handler not found: $pkg.sh (skipping)"
    fi
  done

  print_info "Custom packages installation completed!"
fi
