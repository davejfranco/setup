#!/usr/bin/env bash

source ../../util/util.sh

print_info "Installing Stow..."

if command -v stow &>/dev/null; then
  print_warning "Stow is already installed"
  return 0
fi

$SUDO apt-get update
$SUDO apt-get install -y stow

print_info "Stow installed successfully!"
