#!/usr/bin/env bash

source ../../util/util.sh

print_info "Installing Neovim..."

if command -v nvim &>/dev/null; then
  print_warning "Neovim is already installed"
  nvim --version | head -n 1
  return 0
fi

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
$SUDO rm -rf /opt/nvim-linux-x86_64
$SUDO tar -C /opt -xzf nvim-linux-x86_64.tar.gz

print_info "Neovim installed successfully!"
nvim --version | head -n 1
