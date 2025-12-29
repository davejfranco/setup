# System Setup Scripts

Automated system configuration scripts for Debian and Arch-based (Omarchy) systems. This project provides a declarative, package-list based approach to system setup, making it easy to maintain and reproduce development environments.

## Overview

This repository contains setup scripts that automate the installation and configuration of development tools and applications across different Linux distributions. It uses a simple, declarative approach inspired by the [omarchy project](https://github.com/basecamp/omarchy), where packages are listed in text files and installed via generic installers.

### Supported Systems

- **Debian-based systems** (Debian, Ubuntu, etc.) - For remote dev environments
- **Arch-based systems** (Omarchy, Arch Linux, etc.) - For local workstations

## Features

- ✅ **Simple Package Management** - Add/remove packages by editing text files
- ✅ **No Code Duplication** - Single installation handlers work across distros
- ✅ **OS-Agnostic Handlers** - Automatically detect and adapt to the package manager
- ✅ **Modular Design** - Easy to extend with custom installation scripts
- ✅ **Clean Output** - Progress indicators and clear status messages
- ✅ **Safe** - Checks for existing installations before proceeding

## Quick Start

### Prerequisites

- **For Debian systems:**
  - `apt-get` package manager
  - `sudo` access
  - `curl` and `wget` (usually pre-installed)

- **For Arch systems:**
  - `pacman` package manager
  - `sudo` access
  - `curl` and `wget` (usually pre-installed)

### Installation

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd setup
   ```

2. Run the setup script for your system:

   **For Debian-based systems:**
   ```bash
   ./setup.sh debian
   ```

   **For Omarchy (Arch-based) systems:**
   ```bash
   ./setup.sh omarchy
   ```

   **Or run directly:**
   ```bash
   ./debian/main.sh      # Debian
   ./omarchy/main.sh     # Omarchy
   ```

## What Gets Installed

### Debian System Packages

**Standard packages (via apt):**
- System utilities: curl, wget, git, unzip, htop, gnupg, ca-certificates, lsb-release, python3-pip
- Development tools: build-essential
- Shell: zsh, stow, bat

**Custom installations:**
- Docker (with Docker Compose)
- Neovim (latest from GitHub)
- Terraform
- OpenTofu
- Ansible
- kubectl
- k9s
- kubectx
- AWS CLI
- Starship prompt
- NerdFonts (JetBrainsMono)
- uv (Python package manager)

### Omarchy (Arch) System Packages

**Standard packages (via pacman):**
- System utilities: curl, wget, git, unzip, htop
- Development: base-devel, python-pip
- Shell: zsh, stow, bat
- Applications: vlc, vlc-plugins-all, unrar, docker, k9s

**Custom installations:**
- Neovim (latest from GitHub)
- kubectl
- kubectx
- AWS CLI
- Terraform
- OpenTofu
- Ansible
- Starship prompt
- NerdFonts (JetBrainsMono)
- uv (Python package manager)

## Project Structure

```
setup/
├── install/
│   ├── custom/                    # Custom installation handlers
│   │   ├── ansible.sh
│   │   ├── awscli.sh
│   │   ├── docker.sh
│   │   ├── k9s.sh
│   │   ├── kubectl.sh
│   │   ├── kubectx.sh
│   │   ├── neovim.sh
│   │   ├── nerdfont.sh
│   │   ├── opentofu.sh
│   │   ├── starship.sh
│   │   ├── terraform.sh
│   │   └── uv.sh
│   ├── debian-base.packages       # Debian package list
│   └── omarchy-base.packages      # Omarchy package list
├── pkg/
│   ├── common/                    # Shared utilities
│   │   ├── hostname.sh
│   │   └── user.sh
│   ├── install-apt.sh             # Generic APT installer
│   └── install-pacman.sh          # Generic Pacman installer
├── debian/
│   └── main.sh                    # Debian entry point
├── omarchy/
│   └── main.sh                    # Omarchy entry point
├── util/
│   └── util.sh                    # Utility functions
├── setup.sh                       # Main entry point
├── plan.md                        # Refactoring documentation
└── README.md                      # This file
```

## Adding New Packages

### Simple Packages (Available in apt/pacman)

1. Edit the appropriate package list:
   - For Debian: `install/debian-base.packages`
   - For Omarchy: `install/omarchy-base.packages`

2. Add the package name on a new line:
   ```bash
   # Development tools
   tmux
   ripgrep
   fd-find
   ```

3. Run the setup script - the new package will be installed automatically

### Complex Packages (Require Custom Installation)

1. Create a custom handler in `install/custom/`:
   ```bash
   #!/usr/bin/env bash
   
   SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
   PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
   
   source "$PROJECT_ROOT/util/util.sh"
   
   print_info "Installing MyPackage..."
   
   # Check if already installed
   if command -v mypackage &>/dev/null; then
     print_warning "MyPackage is already installed"
     return 0
   fi
   
   # Install based on package manager
   if command -v apt-get &>/dev/null; then
     # Debian installation logic
     sudo apt-get install -y mypackage
   elif command -v pacman &>/dev/null; then
     # Arch installation logic
     sudo pacman -S --needed --noconfirm mypackage
   fi
   
   print_info "MyPackage installed successfully!"
   ```

2. Make it executable:
   ```bash
   chmod +x install/custom/mypackage.sh
   ```

3. Add reference to the package list:
   ```bash
   # In install/debian-base.packages or install/omarchy-base.packages
   CUSTOM:mypackage
   ```

## Package List Format

Package list files (`.packages`) use a simple format:

```bash
# This is a comment - lines starting with # are ignored

# Blank lines are also ignored

# Standard packages (one per line)
curl
wget
git

# Custom packages (need handlers in install/custom/)
CUSTOM:docker
CUSTOM:neovim
CUSTOM:terraform
```

## Utility Functions

The project provides utility functions in `util/util.sh`:

- `print_info "message"` - Print info message in green
- `print_error "message"` - Print error message in red
- `print_warning "message"` - Print warning message in yellow
- `check_sudo` - Check if running with sudo/root privileges

## Post-Installation

After running the setup script:

1. **Log out and back in** for group permissions to take effect (especially for Docker)
2. **Verify installations:**
   ```bash
   docker --version
   nvim --version
   terraform --version
   kubectl version --client
   ```

3. **Configure tools** as needed (git config, AWS credentials, etc.)

## Troubleshooting

### Script fails with "Permission denied"

Make sure the script is executable:
```bash
chmod +x setup.sh
chmod +x debian/main.sh
chmod +x omarchy/main.sh
```

### Package installation fails

- Check your internet connection
- Verify you have sudo privileges
- For Debian: Run `sudo apt-get update` first
- For Arch: Run `sudo pacman -Sy` first

### Docker commands fail after installation

You need to log out and back in for Docker group permissions to take effect. Alternatively:
```bash
newgrp docker
```

### Custom handler not found

Ensure:
1. The handler exists in `install/custom/`
2. The handler is executable (`chmod +x`)
3. The package list references it correctly (`CUSTOM:packagename`)

## Development

### Testing Changes

Before running on a production system, test your changes:

1. **Syntax check:**
   ```bash
   bash -n setup.sh
   bash -n debian/main.sh
   bash -n omarchy/main.sh
   ```

2. **Dry run** - Review what would be installed:
   ```bash
   cat install/debian-base.packages | grep -v '^#' | grep -v '^$'
   ```

### Contributing

1. Create custom handlers in `install/custom/`
2. Make them OS-agnostic when possible (detect package manager)
3. Test on both Debian and Arch if applicable
4. Update package lists accordingly
5. Document any special requirements

## Design Philosophy

This project follows these principles:

- **Declarative over Imperative** - List what you want, not how to get it
- **DRY (Don't Repeat Yourself)** - Single source of truth for each package
- **Simple over Complex** - Text files over YAML/JSON/XML
- **OS-Agnostic** - One handler works across distributions
- **Safe Defaults** - Check before installing, fail gracefully

## Comparison with Other Tools

### vs Ansible/Chef/Puppet
- ✅ Simpler - Just bash scripts and text files
- ✅ No dependencies - No need to install configuration management tools
- ✅ Faster - Direct package manager usage
- ❌ Less powerful - Not designed for complex orchestration

### vs Docker/Containers
- ✅ Bare metal - Sets up the actual system, not a container
- ✅ Persistent - Changes survive reboots
- ❌ Not portable - Tied to the OS
- ❌ Not reproducible - Can vary based on package versions

### vs Manual Installation
- ✅ Automated - One command vs many
- ✅ Documented - Package lists serve as documentation
- ✅ Reproducible - Same setup every time
- ✅ Maintainable - Easy to update and modify

## License

[Add your license here]

## Acknowledgments

- Inspired by [basecamp/omarchy](https://github.com/basecamp/omarchy)
- Built for managing Debian remote dev environments and Omarchy workstations

## Support

For issues or questions:
1. Check the [Troubleshooting](#troubleshooting) section
2. Review `plan.md` for implementation details
3. [Open an issue / contact information]

---

**Last Updated**: December 2024  
**Maintained by**: [Your Name]
