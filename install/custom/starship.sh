#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing starship..."

# Determine the user - use parameter if provided, otherwise use current user
if [[ -n "$1" ]]; then
  TARGET_USER="$1"
elif [[ -n "$SUDO_USER" ]]; then
  TARGET_USER="$SUDO_USER"
else
  TARGET_USER="$USER"
fi

# Install starship based on package manager
if command -v apt-get &>/dev/null; then
  $SUDO apt-get update
  $SUDO apt-get install -y starship
elif command -v pacman &>/dev/null; then
  $SUDO pacman -S --needed --noconfirm starship
fi

# Create .zshrc if it doesn't exist
if [[ ! -f /home/"$TARGET_USER"/.zshrc ]]; then
  $SUDO touch /home/"$TARGET_USER"/.zshrc
  $SUDO chown "$TARGET_USER":"$TARGET_USER" /home/"$TARGET_USER"/.zshrc
fi

# Add starship init to .zshrc if not already present
if ! grep -q 'starship init zsh' /home/"$TARGET_USER"/.zshrc 2>/dev/null; then
  $SUDO bash -c "echo 'eval \"\$(starship init zsh)\"' >> /home/\"$TARGET_USER\"/.zshrc"
fi

print_info "starship installed successfully for user: $TARGET_USER"
