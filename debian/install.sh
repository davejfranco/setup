#!/bin/bash

# Debian package installation script
# Installs: Docker, Terraform, OpenTofu, Ansible, and Neovim

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_info() {
  echo -e "${GREEN}[INFO]${NC} $1"
}

print_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
  echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check if running as root or with sudo
check_sudo() {
  if [ "$EUID" -eq 0 ]; then
    SUDO=""
  else
    SUDO="sudo"
  fi
}

install_stow() {
  print_info "Installing Stow..."

  if command -v stow &>/dev/null; then
    print_warning "Stow is already installed"
    return 0
  fi

  $SUDO apt-get update
  $SUDO apt-get install -y stow

  print_info "Stow installed successfully!"
}

# Install Docker
install_docker() {
  print_info "Installing Docker..."

  if command -v docker &>/dev/null; then
    print_warning "Docker is already installed"
    docker --version
    return 0
  fi

  # Install prerequisites
  $SUDO apt-get update
  $SUDO apt-get install -y ca-certificates curl gnupg lsb-release

  # Add Docker's official GPG key
  $SUDO install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg | $SUDO gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  $SUDO chmod a+r /etc/apt/keyrings/docker.gpg

  # Set up the repository
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
    $SUDO tee /etc/apt/sources.list.d/docker.list >/dev/null

  # Install Docker Engine
  $SUDO apt-get update
  $SUDO apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  # Add current user to docker group
  if [ -n "$SUDO_USER" ]; then
    $SUDO usermod -aG docker $SUDO_USER
    print_info "Added $SUDO_USER to docker group. You may need to log out and back in."
  elif [ "$EUID" -ne 0 ]; then
    $SUDO usermod -aG docker $USER
    print_info "Added $USER to docker group. You may need to log out and back in."
  fi

  print_info "Docker installed successfully!"
  docker --version
}

# Install Terraform
install_terraform() {
  print_info "Installing Terraform..."

  if command -v terraform &>/dev/null; then
    print_warning "Terraform is already installed"
    terraform --version
    return 0
  fi

  # Install prerequisites
  $SUDO apt-get update
  $SUDO apt-get install -y gnupg software-properties-common

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
}

# Install OpenTofu
install_opentofu() {
  print_info "Installing OpenTofu..."

  if command -v tofu &>/dev/null; then
    print_warning "OpenTofu is already installed"
    tofu --version
    return 0
  fi

  # Download opentofu install script
  curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh \
    -o /tmp/install-opentofu.sh

  # Make script executable
  chmod +x /tmp/install-opentofu.sh

  # Execute install script
  /tmp/install-opentofu.sh

  # Remove install script
  rm /tmp/install-opentofu.sh

  print_info "OpenTofu installed successfully!"
  tofu --version
}

# Install Ansible
install_ansible() {
  print_info "Installing Ansible..."

  if command -v ansible &>/dev/null; then
    print_warning "Ansible is already installed"
    ansible --version
    return 0
  fi

  # Install prerequisites
  $SUDO apt-get update
  $SUDO apt-get install -y python3-pip

  # Install Ansible via pip
  $SUDO pip3 install ansible

  print_info "Ansible installed successfully!"
  ansible --version
}

# Install Neovim
install_neovim() {
  print_info "Installing Neovim..."

  if command -v nvim &>/dev/null; then
    print_warning "Neovim is already installed"
    nvim --version | head -n 1
    return 0
  fi

  # Install Neovim from apt
  $SUDO apt-get update
  $SUDO apt-get install -y neovim

  print_info "Neovim installed successfully!"
  nvim --version | head -n 1
}

# Install aws-cli
install_awscli() {
  print_info "Installing aws-cli"
}
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

  # Install each package
  install_stow
  echo ""

  install_docker
  echo ""

  install_terraform
  echo ""

  install_opentofu
  echo ""

  install_ansible
  echo ""

  install_neovim
  echo ""

  install_awscli
  echo ""

  print_info "All packages installed successfully!"
  print_info "You may need to log out and back in for Docker group permissions to take effect."
}

# Run main function
main "$@"
