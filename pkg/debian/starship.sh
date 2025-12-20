#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing starship..."

$SUDO apt update
$SUDO apt install -y starship

echo 'eval "$(starship init zsh)"' >> ~/.zshrc

print_info "starship installed successfully!"

