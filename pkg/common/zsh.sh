#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing zsh..."

$SUDO apt-get update
$SUDO apt-get install -y zsh

print_info "setting zsh as default shell for $USER"
$SUDO usermod -s $(which zsh) $USER

print_info "zsh installed successfully!"

