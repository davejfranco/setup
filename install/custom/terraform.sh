#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing Terraform..."

if command -v terraform &>/dev/null; then
  print_warning "Terraform is already installed"
  terraform --version
  return 0
fi

# Install based on package manager
if command -v apt-get &>/dev/null; then
  # Add HashiCorp GPG key
  wget -O- https://apt.releases.hashicorp.com/gpg |
    gpg --dearmor |
    $SUDO tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null

  # Add HashiCorp repository
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
        https://apt.releases.hashicorp.com $(lsb_release -cs) main" |
    $SUDO tee /etc/apt/sources.list.d/hashicorp.list

  # Install Terraform
  $SUDO apt-get update
  $SUDO apt-get install -y terraform
elif command -v pacman &>/dev/null; then
  # Terraform is available in Arch community repo
  $SUDO pacman -S --needed --noconfirm terraform
fi

print_info "Terraform installed successfully!"
terraform --version
