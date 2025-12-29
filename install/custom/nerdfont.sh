#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing NerdFonts..."

# Detect package manager and install fontconfig
if command -v apt-get &>/dev/null; then
    $SUDO apt-get update
    $SUDO apt-get install -y fontconfig
elif command -v pacman &>/dev/null; then
    $SUDO pacman -S --needed --noconfirm fontconfig
fi

# Create fonts directory
$SUDO mkdir -p /usr/local/share/fonts/NerdFonts

# Download and install JetBrainsMono Nerd Font
curl -L \
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip \
  -o /tmp/JetBrainsMono.zip

unzip -o /tmp/JetBrainsMono.zip -d /tmp/JetBrainsMono

$SUDO mv /tmp/JetBrainsMono/*.ttf /usr/local/share/fonts/NerdFonts/
$SUDO fc-cache -fv

# Cleanup
rm -rf /tmp/JetBrainsMono /tmp/JetBrainsMono.zip

print_info "NerdFonts installed successfully!"
