#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing Docker..."

if command -v docker &>/dev/null; then
  print_warning "Docker is already installed"
  docker --version
  return 0
fi

# For Debian-based systems, we need to add Docker repository
# For Arch, docker is installed via pacman in the base packages list
if command -v apt-get &>/dev/null; then
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
fi

# Add current user to docker group (works for both Debian and Arch)
if [ -n "$SUDO_USER" ]; then
  $SUDO usermod -aG docker $SUDO_USER
  print_info "Added $SUDO_USER to docker group. You may need to log out and back in."
elif [ "$EUID" -ne 0 ]; then
  $SUDO usermod -aG docker $USER
  print_info "Added $USER to docker group. You may need to log out and back in."
fi

print_info "Docker installed successfully!"
docker --version
