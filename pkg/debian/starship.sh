#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

print_info "Installing starship..."

USER=$1
if [[ -z "$1" ]]; then
  print_error "User is required"
  exit 1
fi

$SUDO apt update
$SUDO apt install -y starship

if ! grep -q 'starship init zsh' /home/"$USER"/.zshrc 2>/dev/null; then
  $SUDO echo 'eval "$(starship init zsh)"' >> /home/"$USER"/.zshrc
fi

$SUDO mkdir -p /home/"$USER"/.config

$SUDO cat <<EOF > /home/"$USER"/.config/starship.toml
# Get editor completions based on the config schema
"\$schema" = 'https://starship.rs/config-schema.json'

# Inserts a blank line between shell prompts
add_newline = true

# Replace the '❯' symbol in the prompt with '➜'
[character] # The name of the module we are configuring is 'character'
success_symbol = '[➜](bold green)' # The 'success_symbol' segment is being set to '➜' with the color 'bold green'

# Disable the package module, hiding it from the prompt completely
[package]
disabled = true
EOF

$SUDO chown -R "$USER":"$USER" /home/"$USER"/.config
print_info "starship installed successfully!"

