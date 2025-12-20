#!/bin/bash

# Debian package installation script
# Installs: Docker, Terraform, OpenTofu, Ansible, and Neovim

source ../util/util.sh


# Main installation function
main() {
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
  source ../pkg/debian/pre-requisites.sh
  echo ""

  # Install each package
  source ../pkg/common/uv.sh
  echo ""

  source ../pkg/debian/stow.sh
  echo ""

  source ../pkg/debian/docker.sh
  echo ""

  source ../pkg/debian/terraform.sh
  echo ""

  source ../pkg/debian/opentofu.sh
  echo ""

  source ../pkg/debian/ansible.sh
  echo ""

  source ../pkg/common/neovim.sh
  echo ""

  source ../pkg/common/awscli.sh
  echo ""

  print_info "All packages installed successfully!"
  print_info "You may need to log out and back in for Docker group permissions to take effect."
}

# Run main function
main "$@"
