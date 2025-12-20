#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

# Check if hostname parameter is provided
if [ -z "$1" ]; then
  print_error "Hostname parameter is required"
  print_info "Usage: source hostname.sh <hostname>"
  return 1
fi

HOSTNAME="$1"

print_info "Configuring hostname..."

# Check if sudoers rule already exists
SUDOERS_FILE="/etc/sudoers.d/hostnamectl"
if [ -f "$SUDOERS_FILE" ]; then
  print_warning "Sudoers rule for hostnamectl already exists, skipping creation"
else
  print_info "Creating sudoers rule for passwordless hostnamectl..."
  echo "$USER ALL=(ALL) NOPASSWD: /usr/bin/hostnamectl" | $SUDO tee "$SUDOERS_FILE" > /dev/null
  
  if [ $? -eq 0 ]; then
    $SUDO chmod 440 "$SUDOERS_FILE"
    print_info "Sudoers rule created successfully"
  else
    print_warning "Failed to create sudoers rule, you may need to enter password for hostnamectl"
  fi
fi

# Set hostname
print_info "Setting hostname to '$HOSTNAME'..."
$SUDO hostnamectl hostname "$HOSTNAME"

print_info "Hostname configured successfully!"
