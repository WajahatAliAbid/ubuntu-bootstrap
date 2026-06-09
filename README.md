# Ubuntu Bootstrap

An automated bootstrap script for setting up Ubuntu development environments with essential tools, languages, and applications.

## Features

- **Ubuntu-focused**: Specifically designed and tested for Ubuntu (no multi-distro complexity)
- **Modular installation**: Install everything at once or pick specific sections
- **Update support**: Re-run scripts marked for updates
- **Idempotent**: Safe to run multiple times

## What Gets Installed

### Core System
- Essential packages (git, curl, build-essential, networking tools)
- System configuration

### Programming Languages
- **Python**: Python 3, pip, pipx, venv, development libraries
- **Node.js**: Node.js and npm

### Development Tools
- **Version Managers**: pyenv, tfenv
- **CLI Tools**: GitHub CLI, Cloc, Claude CLI, Btop
- **Infrastructure**: Docker, Terraform, AWS CLI
- **Database**: PostgreSQL client

### Python Tools (via pipx)
- uv (Python package manager)
- hatch (Python project manager)
- ruff (linter/formatter)
- tldr (simplified man pages)

### Desktop Applications
- **Browsers**: Google Chrome
- **Development**: VSCode
- **Communication**: Slack
- **Utilities**: Remmina (RDP), MPV (media player), LibreOffice
- **Creative**: OBS Studio, Krita
- **Database**: PGAdmin
- **System**: Partition Manager

## Usage

### Install Everything

```bash
./bootstrap.sh install
```

### Install with System Updates

Run system updates before installation:

```bash
./bootstrap.sh install --update
```

### Update Installed Tools

Re-run scripts marked with `meta:update: true`:

```bash
./bootstrap.sh update
```

### Customize Installation

To install only specific tools, edit `bootstrap.sh` and remove unwanted scripts from the section arrays before running `install`.

## Requirements

- Ubuntu (22.04 LTS or newer recommended)
- Internet connection
- `sudo` access

## Structure

```
ubuntu-bootstrap/
├── bootstrap.sh                          # Main entry point
├── scripts/
│   ├── _helpers.sh                       # Shared helper functions
│   ├── run_updates.sh                    # System update script
│   ├── config.sh                         # System configuration
│   ├── core_packages.sh                  # Core system packages
│   ├── languages/                        # Programming language installers
│   │   ├── python.sh
│   │   ├── nodejs.sh
│   │   └── tools/
│   │       └── python/                   # Python-specific tools
│   ├── tools/                            # Development tools
│   │   ├── docker.sh
│   │   ├── awscli.sh
│   │   ├── pyenv.sh
│   │   └── ...
│   └── programs/                         # Desktop applications
│       ├── chrome.sh
│       ├── vscode.sh
│       └── ...
```

## Script Metadata

Each installation script includes metadata comments:

- `meta:update: true|false` - Whether to re-run during updates
- `meta:description` - What the script installs
- `meta:link` - Reference documentation URLs

## Helper Functions

The `scripts/_helpers.sh` file provides utility functions:

- `download_file(url, [filename])` - Download files with caching
- `download_git_release_file(repo, filename, [release])` - Download from GitHub releases
- `get_git_release_version(repo)` - Get latest release version
- `install_pip_tool(name)` - Install Python tools via pipx
- `install_npm_tool(name)` - Install Node tools globally

## Safety

- All scripts are idempotent (safe to run multiple times)
- Scripts check if tools are already installed before proceeding
- Uses `set -euo pipefail` for error handling
- Downloads are cached in `/tmp` to avoid re-downloading

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT License - See [LICENSE](LICENSE) for details.

## Acknowledgments

This bootstrap script automates the installation of many excellent open-source tools. Each tool is the work of its respective maintainers and communities.
