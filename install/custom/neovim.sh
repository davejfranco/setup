#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing Neovim..."

if command -v nvim &>/dev/null; then
  print_warning "Neovim is already installed"
  nvim --version | head -n 1
  return 0
fi

DISTRO=$(uname)
case "$DISTRO" in
  "Linux")
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    $SUDO rm -rf /opt/nvim-linux-x86_64
    $SUDO tar -C /opt -xzf nvim-linux-x86_64.tar.gz
    ;;
  "Darwin")
    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz
    tar xzf nvim-macos-arm64.tar.gz
    ./nvim-macos-arm64/bin/nvim
    ;;
esac

print_info "Neovim installed successfully!"
nvim --version | head -n 1
