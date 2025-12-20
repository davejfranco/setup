#!/usr/bin/env bash

source ../../util/util.sh

print_info "Installing Terraform..."

if command -v terraform &>/dev/null; then
  print_warning "Terraform is already installed"
  terraform --version
  return 0
fi

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

print_info "Terraform installed successfully!"
terraform --version
