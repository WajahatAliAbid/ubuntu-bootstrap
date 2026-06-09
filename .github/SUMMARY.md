# Ubuntu Bootstrap - Project Summary

## Overview

Open-source Ubuntu bootstrap script for automated development environment setup.

## Key Features

- **Ubuntu-only**: No multi-distro complexity
- **Simplified CLI**: Only `install` and `update` commands
- **Modular**: Organized into core, languages, tools, programs sections
- **Idempotent**: Safe to run multiple times
- **Well-documented**: README, QUICKSTART, and CONTRIBUTING guides

## What's Included

### Core System (2 scripts)
- System packages (git, curl, build-essential, networking tools)
- System configuration

### Languages (2 scripts)
- Python (with pip, pipx, venv)
- Node.js

### Development Tools (9 scripts)
- Version managers: pyenv, tfenv
- Containers: Docker
- Cloud: AWS CLI
- Databases: PostgreSQL client
- CLI tools: GitHub CLI, Cloc, Claude CLI, Btop

### Python Tools (4 scripts)
- uv, hatch, ruff, tldr

### Desktop Applications (10 scripts)
- Chrome, VSCode, Slack, Remmina, MPV, LibreOffice
- OBS Studio, Krita, PGAdmin, Partition Manager

**Total: 29 installation scripts**

## Commands

```bash
# Install everything
./bootstrap.sh install

# Install with OS updates
./bootstrap.sh install --update

# Update installed tools
./bootstrap.sh update
```

## Customization

Edit `bootstrap.sh` and remove unwanted tools from section arrays before running `install`.

## File Structure

```
ubuntu-bootstrap/
├── bootstrap.sh              # Main entry point
├── README.md                 # Full documentation
├── QUICKSTART.md            # Quick start guide
├── CONTRIBUTING.md          # Contribution guidelines
├── LICENSE                  # MIT License
└── scripts/
    ├── _helpers.sh          # Utility functions (133 lines)
    ├── config.sh            # System configuration
    ├── core_packages.sh     # Essential packages
    ├── run_updates.sh       # OS updates
    ├── languages/           # Programming languages
    ├── tools/               # Development tools (9 scripts)
    └── programs/            # Desktop applications (10 scripts)
```

## Helper Functions

Only includes functions that are actually used:
- `download_file()` - Download files with caching
- `download_git_release_file()` - Download from GitHub releases
- `get_git_release_version()` - Get latest release version
- `install_pip_tool()` - Install Python tools via pipx
- `install_npm_tool()` - Install Node tools globally

Removed unused functions:
- `install_go_tool()` (no Go tools)
- `install_cargo_tool()` (no Rust tools)
- `install_dotnet_tool()` (no .NET tools)
- `install_dotnet_template()` (no .NET tools)

## Design Principles

1. **Simple**: Two commands only (install, update)
2. **Safe**: Idempotent scripts with error handling
3. **Clear**: Descriptive output and comments
4. **Ubuntu-focused**: No OS detection or multi-distro logic
5. **Lean**: Only helper functions that are actually used
6. **Open**: MIT licensed, contribution-friendly

## Removed from Original

- Profile support (`--profile` flag)
- Section command (user edits script for customization)
- Fedora support (all `.fedora.sh` files)
- Font installation
- Hyprland/NVIDIA setup
- Go/Rust/C++/Lua tools (lazygit, ripgrep, etc.)
- Unused helper functions
- 150+ tools not in scope

## Ready for

- Public release
- Open source contributions
- Fresh Ubuntu installations
- Development environment automation
