#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing kuebctx..."

$SUDO pacman -S --needed --noconfirm kubectx

print_info "kubectx installed successfully!"
