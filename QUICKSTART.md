# Quick Start Guide

## Prerequisites

- Fresh Ubuntu installation (22.04 LTS or newer)
- Internet connection
- sudo privileges

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/ubuntu-bootstrap.git
cd ubuntu-bootstrap
```

### 2. Make Bootstrap Script Executable

```bash
chmod +x bootstrap.sh
```

### 3. Run Installation

#### Install Everything

```bash
./bootstrap.sh install
```

This will install:
- Core system packages
- Python and Node.js
- All development tools
- All desktop applications

#### Install with System Updates

Run OS updates before installation:

```bash
./bootstrap.sh install --update
```

### 4. Post-Installation

Some tools may require:

- **Docker**: Log out and back in for group permissions
- **Python tools**: Ensure `~/.local/bin` is in your PATH
- **Shell changes**: Restart your terminal or run `source ~/.bashrc`

## Common Issues

### Permission Denied

Make sure the script is executable:
```bash
chmod +x bootstrap.sh
```

### Script Not Found Errors

Ensure you're running from the project root directory:
```bash
cd /path/to/ubuntu-bootstrap
./bootstrap.sh install
```

### Tool Already Installed

The scripts are idempotent - they check if tools are already installed. You can safely re-run any script.

## Updating Tools

Some scripts are marked for updates. Run this to update them:

```bash
./bootstrap.sh update
```

## What Gets Installed?

See [README.md](README.md) for the complete list of tools and applications.

## Customization

To exclude certain tools:
1. Edit `bootstrap.sh`
2. Remove the tool's script path from the appropriate section array
3. Run the installation

## Getting Help

- Read the full [README.md](README.md)
- Check [CONTRIBUTING.md](CONTRIBUTING.md) for technical details
- Open an issue on GitHub

## Next Steps

After installation:

1. **Configure Git**:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

2. **Set up Docker** (if installed):
   ```bash
   sudo usermod -aG docker $USER
   # Log out and back in
   ```

3. **Install Python packages**:
   ```bash
   # Using uv (if installed)
   uv pip install <package>
   
   # Using pipx for tools
   pipx install <tool>
   ```

4. **Configure VSCode** (if installed):
   - Install extensions
   - Set up settings sync
   - Configure themes

5. **Set up cloud CLIs** (if installed):
   ```bash
   # AWS
   aws configure
   ```

Enjoy your new development environment! 🚀
