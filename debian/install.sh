#!/bin/bash

# Debian package installation script
# Installs: Docker, Terraform, OpenTofu, Ansible, and Neovim

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

source "$PROJECT_ROOT/util/util.sh"

# Main installation function
install() {
  print_info "Starting Debian package installation..."
  print_info "Packages to install: Stow, Docker, Terraform, OpenTofu, Ansible, Neovim"
  echo ""

  check_sudo

  # Check if running on Debian-based system
  if ! command -v apt-get &>/dev/null; then
    print_error "This system does not appear to be Debian-based"
    exit 1
  fi

  # Install dependencies
  source "$PROJECT_ROOT/pkg/debian/pre-requisites.sh"
  echo ""

  source "$PROJECT_ROOT/pkg/common/nerdfont.sh"
  echo ""

  source "$PROJECT_ROOT/pkg/common/zsh.sh"
  echo ""

  source "$PROJECT_ROOT/pkg/debian/starship.sh"
  echo ""

  # Install each package
  source "$PROJECT_ROOT/pkg/common/uv.sh"
  echo ""

  source "$PROJECT_ROOT/pkg/debian/stow.sh"
  echo ""

  source "$PROJECT_ROOT/pkg/debian/docker.sh"
  echo ""

  source "$PROJECT_ROOT/pkg/debian/terraform.sh"
  echo ""

  source "$PROJECT_ROOT/pkg/debian/opentofu.sh"
  echo ""

  source "$PROJECT_ROOT/pkg/debian/ansible.sh"
  echo ""

  source "$PROJECT_ROOT/pkg/common/neovim.sh"
  echo ""

  source "$PROJECT_ROOT/pkg/common/awscli.sh"
  echo ""

  print_info "All packages installed successfully!"
  print_info "You may need to log out and back in for Docker group permissions to take effect."
}
