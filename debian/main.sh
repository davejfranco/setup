#!/bin/bash

# Debian package installation script
# Installs: Docker, Terraform, OpenTofu, Ansible, and Neovim

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/util/util.sh"
source "$PROJECT_ROOT/debian/install.sh"

print_info "Changing hostname..."
$SUDO hostnamectl hostname demo

# Run Installation script 
installation "$@"
