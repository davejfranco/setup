#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$PROJECT_ROOT/util/util.sh"

NEWUSER=$1

if [[ -z "$1" ]]; then
  print_error "No username provided"
  return
fi

if id "$NEWUSER" >/dev/null 2>&1; then
  print_info "User $NEWUSER already exists..."
  return
fi

print_info "Creating user $NEWUSER..."

$SUDO useradd -m -s /usr/bin/zsh -G admin,docker,sudo $NEWUSER 
$SUDO bash -c "cat > /etc/sudoers.d/91-$NEWUSER" <<EOF
$NEWUSER ALL=(ALL) NOPASSWD:ALL
EOF

print_info "Copying ec2 ssh keys to $NEWUSER..."
$SUDO mkdir /home/"$NEWUSER"/.ssh
$SUDO cp ~/.ssh/authorized_keys /home/"$NEWUSER"/.ssh/authorized_keys
$SUDO chown -R "$NEWUSER":"$NEWUSER" /home/"$NEWUSER"/.ssh
