---
name: ubuntu-bootstrap
description: |
  Manages tool installation scripts for the ubuntu-bootstrap repository. Use this skill whenever the user:
  - Wants to add a new tool, program, or application to ubuntu-bootstrap
  - Asks to create an installation script for any software
  - Mentions modifying or updating ubuntu-bootstrap tool scripts
  - Requests script validation or consistency checks
  - Is working with files in the ubuntu-bootstrap directory structure
  - Asks about which tools are available in Ubuntu repositories
  
  This skill handles the complete workflow: researching the tool, verifying Ubuntu availability, generating properly formatted scripts with metadata, updating configuration files, and validating conventions.
---

# Ubuntu Bootstrap Tool Manager

This skill helps you add and manage tool installation scripts in the ubuntu-bootstrap repository.

## Understanding the Repository Structure

The ubuntu-bootstrap repository uses this structure:

```
ubuntu-bootstrap/
├── bootstrap.sh              # Main script with section arrays
├── scripts/
│   ├── _helpers.sh          # Helper functions
│   ├── core_packages.sh     # System essentials
│   ├── config.sh            # System configuration
│   ├── run_updates.sh       # OS updates
│   ├── languages/           # Programming languages (python.sh, nodejs.sh)
│   │   └── tools/
│   │       └── python/      # Python-specific tools (uv, hatch, ruff, tldr)
│   ├── tools/               # Development tools (docker, awscli, pyenv, etc.)
│   └── programs/            # Desktop applications (chrome, vscode, slack, etc.)
```

## When to Use This Skill

Use this skill when the user wants to:
1. Add a new tool, program, or application to the bootstrap script
2. Modify an existing installation script
3. Validate that scripts follow project conventions
4. Check if a tool is available in Ubuntu repositories

## Step 1: Gather Tool Information

When the user wants to add a tool, gather:

1. **Tool name**: What is it called?
2. **Purpose**: What does it do? (for metadata description)
3. **Category**: Determine where it belongs:
   - `scripts/languages/` - Programming languages (Python, Node.js, etc.)
   - `scripts/languages/tools/python/` - Python-specific tools installed via pipx
   - `scripts/tools/` - Development tools, CLIs, version managers, databases
   - `scripts/programs/` - Desktop applications with GUIs

4. **Installation method**: How should it be installed?
   - Ubuntu apt package
   - Download from GitHub releases
   - Install via pip/pipx (for Python tools)
   - Install via npm (for Node.js tools)
   - Download from official website

## Step 2: Research and Verify

Before creating the script, verify the tool is available for Ubuntu:

### For apt packages:
```bash
# Check if package exists in Ubuntu repositories
apt-cache search <package-name>
apt-cache show <package-name>  # Get detailed info
```

### For other installation methods:
- Check the official website and documentation
- Verify GitHub releases if applicable
- Confirm Ubuntu/Linux compatibility
- Find the official download URLs

Gather:
- Official website URL (for `meta:link`)
- Installation guide URL (for `meta:link`)
- Latest version or release info
- Any dependencies or requirements

## Step 3: Generate the Installation Script

Create a script following this exact template:

```bash
#!/usr/bin/env bash
set -euo pipefail

# meta:update: false  # Set to true if this should run during ./bootstrap.sh update
# meta:description <Brief description of what this tool does>
# meta:link <Official website URL>
# meta:link <Installation guide URL> (optional)

source ./scripts/_helpers.sh

# Step: Check if already installed
if command -v <tool-command> &> /dev/null; then
  echo "<tool-name> already installed"
  exit 0
fi

# Step: Installation logic
# <Add installation commands here>

echo "Installed <tool-name>"
```

### Key Conventions

**File naming**: Use lowercase with underscores (e.g., `github_cli.sh`, `obs_studio.sh`)

**Error handling**: Always use `set -euo pipefail` at the top

**Idempotency**: Always check if the tool is already installed before proceeding

**Helper functions**: Use these when applicable:
- `download_file(url, [filename])` - Download files with caching
- `download_git_release_file(repo, filename, [release])` - Download from GitHub releases
- `get_git_release_version(repo)` - Get latest release version
- `install_pip_tool(name)` - Install Python tools via pipx
- `install_npm_tool(name)` - Install Node.js tools globally

**Metadata fields**:
- `meta:update` - Set to `true` only if the tool should be updated when user runs `./bootstrap.sh update`
- `meta:description` - One-line description of what the tool does (used in documentation)
- `meta:link` - Official website or documentation (can have multiple)

**Comments**: Add comments for non-obvious steps, explaining why something is done

**Variables**: Prefix temporary variables with underscore: `_version`, `_path`, `_packages`

### Installation Method Examples

**For apt packages**:
```bash
# Step: Install via apt
sudo apt update -y
sudo apt install -y <package-name>
```

**For GitHub releases**:
```bash
# Step: Download from GitHub releases
_version=$(get_git_release_version "owner/repo")
_path=$(download_git_release_file "owner/repo" "file-name-linux-amd64.tar.gz" "latest")

# Step: Extract and install
tar -xzf "$_path" -C /tmp
sudo install -o root -g root -m 0755 /tmp/binary-name /usr/local/bin/
```

**For Python tools**:
```bash
# Step: Install via pipx
install_pip_tool "<package-name>"
```

**For npm tools**:
```bash
# Step: Install globally via npm
install_npm_tool "<package-name>"
```

**For .deb downloads**:
```bash
# Step: Download and install .deb package
_deb_url="https://example.com/package.deb"
_path=$(download_file "$_deb_url" "package.deb")
sudo dpkg -i "$_path"
```

## Step 4: Update bootstrap.sh

Add the script path to the appropriate section array in `bootstrap.sh`:

**For development tools** - Add to `section_tools`:
```bash
section_tools=(
  ./scripts/tools/pyenv.sh
  ./scripts/tools/tfenv.sh
  # ... existing tools ...
  ./scripts/tools/your-new-tool.sh  # Add here
  "${section_pip_tools[@]}"
)
```

**For desktop programs** - Add to `section_programs`:
```bash
section_programs=(
  ./scripts/programs/chrome.sh
  # ... existing programs ...
  ./scripts/programs/your-new-program.sh  # Add here
)
```

**For programming languages** - Add to `section_languages`:
```bash
section_languages=(
  ./scripts/languages/python.sh
  ./scripts/languages/nodejs.sh
  ./scripts/languages/your-new-language.sh  # Add here
)
```

**For Python tools** - Add to `section_pip_tools`:
```bash
section_pip_tools=(
  ./scripts/languages/tools/python/uv.sh
  # ... existing tools ...
  ./scripts/languages/tools/python/your-new-tool.sh  # Add here
)
```

Maintain alphabetical order within each section when appropriate.

## Step 5: Update README.md

Update the "What Gets Installed" section in README.md to include the new tool.

**For development tools** - Update the "Development Tools" section:
```markdown
### Development Tools
- **Version Managers**: pyenv, tfenv
- **CLI Tools**: GitHub CLI, Cloc, Claude CLI, Btop, Your New Tool
- **Infrastructure**: Docker, Terraform, AWS CLI
- **Database**: PostgreSQL client
```

**For desktop applications** - Update the "Desktop Applications" section:
```markdown
### Desktop Applications
- **Browsers**: Google Chrome
- **Development**: VSCode
- **Communication**: Slack
- **Utilities**: Remmina (RDP), MPV (media player), LibreOffice, Your New Tool
```

**For Python tools** - Update the "Python Tools (via pipx)" section:
```markdown
### Python Tools (via pipx)
- uv (Python package manager)
- hatch (Python project manager)
- ruff (linter/formatter)
- tldr (simplified man pages)
- your-tool (description)
```

## Step 6: Validate the Script

Before finalizing, check that the script:

1. ✅ Starts with `#!/usr/bin/env bash` and `set -euo pipefail`
2. ✅ Has all three metadata fields (`meta:update`, `meta:description`, `meta:link`)
3. ✅ Sources the helpers: `source ./scripts/_helpers.sh`
4. ✅ Checks if already installed before proceeding
5. ✅ Uses appropriate helper functions when available
6. ✅ Has clear comments for non-obvious steps
7. ✅ Ends with a success message
8. ✅ Uses proper variable naming (`_version`, `_path`, etc.)
9. ✅ Is saved in the correct directory
10. ✅ Is added to the appropriate section in `bootstrap.sh`
11. ✅ Is documented in README.md

## Step 7: Make Script Executable

After creating the script, make it executable:

```bash
chmod +x scripts/tools/your-new-tool.sh
```

## Step 8: Test the Script (Optional)

Suggest to the user that they can test the script:

```bash
# Test the individual script
./scripts/tools/your-new-tool.sh

# Or test via bootstrap
./bootstrap.sh install
```

## Common Patterns by Tool Type

### Version Manager Tools
These tools manage multiple versions of languages/tools:
- Should be in `scripts/tools/`
- Often installed via GitHub releases or official installers
- Examples: pyenv, tfenv

### CLI Development Tools
Command-line tools for development workflows:
- Should be in `scripts/tools/`
- Can be apt packages, GitHub releases, or language package managers
- Examples: github_cli, docker, awscli

### Desktop Applications
GUI applications:
- Should be in `scripts/programs/`
- Often installed via apt, snap, or .deb files
- Examples: vscode, chrome, slack

### Python-Specific Tools
Tools installed via pipx for Python development:
- Should be in `scripts/languages/tools/python/`
- Use `install_pip_tool()` helper
- Examples: uv, hatch, ruff

## Handling Edge Cases

**If the tool is not in Ubuntu repositories**:
- Check if it can be installed via snap: `snap find <tool-name>`
- Look for official .deb packages
- Check GitHub releases for Linux binaries
- Consider alternative installation methods (curl install scripts, etc.)

**If the tool requires PPA**:
```bash
# Add PPA repository
sudo add-apt-repository ppa:owner/repository -y
sudo apt update -y
sudo apt install -y <package-name>
```

**If the tool requires multiple steps**:
Break it down with clear comments:
```bash
# Step: Add repository key
curl -fsSL https://example.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/example.gpg

# Step: Add repository
echo "deb [signed-by=/usr/share/keyrings/example.gpg] https://example.com/repo stable main" | \
  sudo tee /etc/apt/sources.list.d/example.list

# Step: Install package
sudo apt update -y
sudo apt install -y <package-name>
```

## Output Summary

After creating or modifying scripts, provide a summary:

```
✅ Created: scripts/tools/new-tool.sh
✅ Updated: bootstrap.sh (added to section_tools)
✅ Updated: README.md (added to Development Tools)
✅ Script made executable
✅ Verified: Tool is available in Ubuntu repositories

Next steps:
- Test with: ./scripts/tools/new-tool.sh
- Or install via: ./bootstrap.sh install
```

## Important Notes

- **Always verify Ubuntu compatibility** - Check apt repositories or official Ubuntu support
- **Follow existing patterns** - Look at similar scripts for reference
- **Keep it simple** - Don't over-complicate installation logic
- **Test idempotency** - Script should be safe to run multiple times
- **Document everything** - Clear metadata and comments help future maintainers
- **Use helper functions** - Don't reinvent the wheel, use what's in `_helpers.sh`
- **Maintain consistency** - Follow the same style as existing scripts
