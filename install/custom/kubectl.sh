#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing kubectl..."

if command -v kubectl &>/dev/null; then
  print_warning "kubectl is already installed"
  kubectl version --client 2>/dev/null || true
  return 0
fi

# Download kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Make it executable and move to /usr/local/bin
chmod +x kubectl
$SUDO mv kubectl /usr/local/bin/kubectl

print_info "kubectl installed successfully!"
kubectl version --client
