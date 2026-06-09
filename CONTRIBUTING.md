# Contributing to Ubuntu Bootstrap

Thank you for considering contributing to this project! This document provides guidelines and instructions for contributing.

## How to Contribute

### Reporting Issues

- Check if the issue already exists before creating a new one
- Provide detailed information:
  - Ubuntu version
  - Steps to reproduce
  - Expected vs actual behavior
  - Relevant error messages or logs
  - Output of `uname -a` and `lsb_release -a`

### Suggesting Enhancements

- Open an issue describing your enhancement
- Explain why this enhancement would be useful
- Provide examples of how it would work

### Adding New Tools

To add a new tool installation script:

1. **Create the script** in the appropriate directory:
   - Core system packages: `scripts/core_packages.sh`
   - Programming languages: `scripts/languages/`
   - Development tools: `scripts/tools/`
   - Desktop applications: `scripts/programs/`
   - Language-specific tools: `scripts/languages/tools/<language>/`

2. **Follow the script template**:

```bash
#!/usr/bin/env bash
set -euo pipefail

# meta:update: false  # Set to true if this should run during updates
# meta:description Brief description of what this installs
# meta:link Official documentation URL
# meta:link Installation guide URL (optional)

source ./scripts/_helpers.sh

# Step: Check if already installed
if command -v <tool-name> &> /dev/null; then
  echo "<tool-name> already installed"
  exit 0
fi

# Step: Installation logic
# Use helper functions when available:
# - download_file()
# - download_git_release_file()
# - install_pip_tool()
# - install_npm_tool()

echo "Installed <tool-name>"
```

3. **Key principles**:
   - **Idempotent**: Script should be safe to run multiple times
   - **Check first**: Always check if the tool is already installed
   - **Clear output**: Print what you're doing
   - **Error handling**: Use `set -euo pipefail` at the top
   - **Comments**: Explain non-obvious steps
   - **Ubuntu-specific**: Only support Ubuntu (no multi-distro logic)

4. **Add to bootstrap.sh**:
   - Add your script path to the appropriate section array (`section_core`, `section_languages`, `section_tools`, `section_programs`, or `section_pip_tools`)
   - Test that it works with `./bootstrap.sh install`

5. **Test your script**:
   - Run it on a fresh Ubuntu installation or VM
   - Verify the tool is installed correctly
   - Run it again to ensure idempotency
   - Confirm it works with `./bootstrap.sh install`

### Code Style

- Use 2 spaces for indentation (no tabs)
- Use descriptive variable names
- Prefix temporary variables with underscore: `_version`, `_path`
- Quote all variables: `"$variable"`
- Use arrays for package lists: `_packages=("pkg1" "pkg2")`
- Add comments for complex operations

### Commit Messages

Follow conventional commits format:

```
<type>: <description>

[optional body]
```

Types:
- `feat`: New feature (new tool installation script)
- `fix`: Bug fix
- `docs`: Documentation changes
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

Examples:
```
feat: add kubectl installation script
fix: correct docker post-install permissions
docs: update README with new tools list
refactor: extract common apt install logic
```

### Pull Request Process

1. **Fork the repository** and create a branch from `main`
2. **Make your changes** following the guidelines above
3. **Test thoroughly** on Ubuntu 22.04 LTS or newer
4. **Update documentation** (README.md) if adding new tools
5. **Commit with clear messages** following the commit format
6. **Open a pull request** with:
   - Clear title describing the change
   - Description of what changed and why
   - Testing steps and results
   - Ubuntu version(s) tested on

### Helper Functions

When writing installation scripts, use the helper functions from `scripts/_helpers.sh`:

#### Download Functions
```bash
# Download a file from URL
download_file "https://example.com/file.tar.gz" "filename.tar.gz"

# Download from GitHub releases
download_git_release_file "owner/repo" "file-name-linux-amd64.tar.gz" "v1.0.0"
# Or use "latest" for latest release
download_git_release_file "owner/repo" "file-name.tar.gz" "latest"

# Get latest release version
version=$(get_git_release_version "owner/repo")
```

#### Package Manager Functions
```bash
# Install Python tool via pipx
install_pip_tool "black"

# Install Node.js tool globally
install_npm_tool "prettier"
```

### What NOT to Include

- **Multi-distro support**: This is Ubuntu-only
- **Font installations**: Keep fonts out of this project
- **Profile-based filtering**: No work/personal profile logic
- **Proprietary tools**: Only open-source or freely available tools
- **Experimental/unstable tools**: Prefer stable releases

### Questions?

- Open an issue for questions about contributing
- Check existing issues and PRs for similar discussions
- Review the codebase for examples

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on what's best for the community
- Show empathy towards others

Thank you for contributing! 🎉
