#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing custom fonts..."

$SUDO apt update
$SUDO apt install -y fontconfig

$SUDO mkdir -p /usr/local/share/fonts/NerdFonts

curl -L \
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip \
  -o /tmp/JetBrainsMono.zip

unzip /tmp/JetBrainsMono.zip -d /tmp/JetBrainsMono

$SUDO mv /tmp/JetBrainsMono/*.ttf /usr/local/share/fonts/NerdFonts/
$SUDO fc-cache -fv

print_info "NerdFonts installed successfully!"
