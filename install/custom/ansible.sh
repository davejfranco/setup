#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing Ansible..."

if command -v ansible &>/dev/null; then
  print_warning "Ansible is already installed"
  ansible --version | head -n 1
  return 0
fi

# Install based on package manager
if command -v apt-get &>/dev/null; then
  # For debian based systems we use Ubuntu repositories
  # https://docs.ansible.com/projects/ansible/latest/installation_guide/installation_distros.html
  UBUNTU_CODENAME=jammy # Latest Ubuntu version
  wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" |
    $SUDO gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg

  echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" |
    $SUDO tee /etc/apt/sources.list.d/ansible.list
  $SUDO apt-get update && $SUDO apt-get install -y ansible
elif command -v pacman &>/dev/null; then
  # Ansible is available in Arch extra repo
  $SUDO pacman -S --needed --noconfirm ansible
fi

print_info "Ansible installed successfully!"
ansible --version | head -n 1
