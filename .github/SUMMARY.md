# Ubuntu Bootstrap - Project Summary

## Overview

Automated bootstrap script for setting up Ubuntu development environments with essential tools, languages, and applications.

## Key Features

- **Ubuntu-focused**: Designed and tested specifically for Ubuntu
- **Simple CLI**: Two commands - `install` and `update`
- **Modular**: Organized into core, languages, tools, and programs sections
- **Idempotent**: Safe to run multiple times without side effects
- **Well-documented**: Comprehensive README, quickstart guide, and contribution guidelines

## What's Included

### Core System (4 scripts)
- Essential packages (git, curl, build-essential, networking tools)
- System configuration
- Package updates
- Helper functions library

### Programming Languages (2 scripts)
- Python (with pip, pipx, venv, and development libraries)
- Node.js (with npm)

### Development Tools (9 scripts)
- **Version Managers**: pyenv (Python), tfenv (Terraform)
- **Containers**: Docker
- **Cloud**: AWS CLI
- **Databases**: PostgreSQL client
- **CLI Utilities**: GitHub CLI, Cloc (code counter), Claude CLI, Btop (system monitor)

### Python Tools (4 scripts)
- uv (fast Python package manager)
- hatch (Python project manager)
- ruff (Python linter and formatter)
- tldr (simplified man pages)

### Desktop Applications (10 scripts)
- **Browser**: Google Chrome
- **Development**: VSCode
- **Communication**: Slack
- **Utilities**: Remmina (remote desktop), MPV (media player), LibreOffice
- **Creative**: OBS Studio (streaming/recording), Krita (digital painting)
- **Database**: PGAdmin
- **System**: KDE Partition Manager

**Total: 29 installation scripts + 1 main bootstrap script**

## Commands

```bash
# Install all tools and applications
./bootstrap.sh install

# Install with OS updates first
./bootstrap.sh install --update

# Update tools marked for updates
./bootstrap.sh update
```

## Customization

To customize which tools get installed, edit `bootstrap.sh` and modify the section arrays:
- `section_core` - System essentials
- `section_languages` - Programming languages
- `section_tools` - Development tools
- `section_pip_tools` - Python-specific tools
- `section_programs` - Desktop applications

Remove any script paths you don't need before running `install`.

## Project Structure

```
ubuntu-bootstrap/
├── bootstrap.sh              # Main entry point (140 lines)
├── README.md                 # Full documentation
├── QUICKSTART.md            # Quick start guide
├── CONTRIBUTING.md          # Contribution guidelines
├── LICENSE                  # MIT License
└── scripts/
    ├── _helpers.sh          # Utility functions (133 lines)
    ├── config.sh            # System configuration
    ├── core_packages.sh     # Essential packages
    ├── run_updates.sh       # OS updates
    ├── languages/           # Programming language installers (2 scripts)
    │   ├── python.sh
    │   ├── nodejs.sh
    │   └── tools/
    │       └── python/      # Python-specific tools (4 scripts)
    ├── tools/               # Development tools (9 scripts)
    └── programs/            # Desktop applications (10 scripts)
```

**Total lines of code: ~1,024**

## Helper Functions

The `scripts/_helpers.sh` provides reusable installation utilities:

**Download helpers:**
- `download_file(url, [filename])` - Download with caching to `/tmp`
- `download_git_release_file(repo, filename, [release])` - Download from GitHub releases
- `get_git_release_version(repo)` - Fetch latest release version

**Package manager helpers:**
- `install_pip_tool(name)` - Install Python tools via pipx
- `install_npm_tool(name)` - Install Node.js tools globally

## Design Principles

1. **Simplicity**: Two commands only (install, update)
2. **Safety**: Idempotent scripts with proper error handling (`set -euo pipefail`)
3. **Clarity**: Clear output, comments for complex operations
4. **Focus**: Ubuntu-only, no multi-distro complexity
5. **Efficiency**: Download caching, skip already-installed tools
6. **Openness**: MIT licensed, contribution-friendly

## Script Metadata

Each installation script includes metadata for documentation and behavior:

```bash
# meta:update: false        # Whether to run during ./bootstrap.sh update
# meta:description ...      # What the script installs
# meta:link https://...     # Official documentation/source
```

## Safety Features

- **Idempotent**: All scripts check if tools are already installed
- **Error handling**: Scripts fail fast with `set -euo pipefail`
- **Download caching**: Files cached in `/tmp` to avoid re-downloading
- **Non-destructive**: Scripts only add tools, never remove or modify existing installations
- **Privilege separation**: Only uses `sudo` when necessary

## Requirements

- Ubuntu 22.04 LTS or newer
- Internet connection
- `sudo` privileges
- Basic system tools (bash, curl)

## Use Cases

Perfect for:
- Setting up fresh Ubuntu installations
- Automating development environment setup
- Standardizing team development environments
- Learning Ubuntu system administration
- Creating reproducible development setups

## Contributing

This project welcomes contributions! See [CONTRIBUTING.md](../CONTRIBUTING.md) for:
- How to add new tool installation scripts
- Code style guidelines
- Testing requirements
- Pull request process

## License

MIT License - Free to use, modify, and distribute. See [LICENSE](../LICENSE) for details.
