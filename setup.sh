#!/bin/bash

# Setup script for omarchy, macOS, and Debian-based systems

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print colored output
print_info() {
  echo -e "${GREEN}[INFO]${NC} $1"
}

print_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
  echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Help function
show_help() {
  cat <<EOF
Usage: ./setup.sh [OPTION]

Setup script for configuring different systems.

Options:
    omarchy        Setup omarchy environment
    macos          Setup macOS system
    debian         Setup Debian-based system
    help           Show this help message

Examples:
    ./setup.sh omarchy
    ./setup.sh macos
    ./setup.sh debian

EOF
}

# Setup omarchy function
setup_omarchy() {
  print_info "Starting omarchy setup..."

  # Add your omarchy setup commands here
  print_info "Installing omarchy dependencies..."
  # Example commands:
  # sudo apt-get update
  # sudo apt-get install -y required-packages

  print_info "Configuring omarchy..."
  # Add configuration steps

  print_info "omarchy setup completed successfully!"
}

# Setup macOS function
setup_macos() {
  print_info "Starting macOS setup..."

  # Check if running on macOS
  if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This system is not macOS"
    exit 1
  fi

  print_info "Installing Homebrew (if not already installed)..."
  if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    print_info "Homebrew already installed"
  fi

  print_info "Installing common packages..."
  # brew install git wget curl vim

  print_info "Configuring macOS settings..."
  # Add macOS configuration commands

  print_info "macOS setup completed successfully!"
}

# Setup Debian-based system function
setup_debian() {
  print_info "Starting Debian-based system setup..."

  # Check if running on Debian-based system
  if ! command -v apt-get &>/dev/null; then
    print_error "This system does not appear to be Debian-based"
    exit 1
  fi

  print_info "Configuring system..."
  # Add configuration steps
  ./debian/main.sh

  print_info "Debian setup completed successfully!"
}

# Main script logic with case statement
main() {
  if [ $# -eq 0 ]; then
    print_error "No option provided"
    show_help
    exit 1
  fi

  case "$1" in
  omarchy)
    setup_omarchy
    ;;
  macos)
    setup_macos
    ;;
  debian)
    setup_debian
    ;;
  help | --help | -h)
    show_help
    ;;
  *)
    print_error "Unknown option: $1"
    show_help
    exit 1
    ;;
  esac
}

# Run main function with all arguments
main "$@"
