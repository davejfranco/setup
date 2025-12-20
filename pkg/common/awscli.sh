#!/usr/bin/env bash

source ../../util/util.sh

print_info "Installing aws-cli"

if command -v aws &>/dev/null; then
  print_warning "aws-cli is already installed"
  aws --version | head -n 1
  return 0
fi

# Download install package
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# unzip
unzip awscliv2.zip
# Install
$SUDO ./aws/install

print_info "aws-cli installed successfully!"
