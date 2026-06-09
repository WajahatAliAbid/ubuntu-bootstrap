#!/usr/bin/env bash
set -euo pipefail

function get_os_identifier() {
    source /etc/os-release
    echo $ID
}

download_git_release_file() {
    local repo="${1:?Usage: download_git_release_file <repo> <file_name> [release]}"
    local file_name="${2:?file_name is required}"
    local release="${3:-latest}"

    local url
    if [[ "$release" == "latest" ]]; then
        url="https://github.com/${repo}/releases/latest/download/${file_name}"
    else
        url="https://github.com/${repo}/releases/download/${release}/${file_name}"
    fi

    local cache_dir="/tmp/git_releases"
    mkdir -p "$cache_dir"

    local file_path="${cache_dir}/${file_name}"

    if ! curl -fsSL "$url" -o "$file_path"; then
        echo "Error: Failed to download '${file_name}' from '${url}'" >&2
        return 1
    fi

    echo "$file_path"
}

get_git_release_version() {
    local repo_name="${1:?Usage: get_git_release_version <owner/repo>}"

    local response
    response=$(curl --silent --fail --location \
        --header "Accept: application/vnd.github+json" \
        --header "X-GitHub-Api-Version: 2022-11-28" \
        "https://api.github.com/repos/${repo_name}/releases/latest") || {
        echo "Error: Failed to fetch release for '${repo_name}'" >&2
        return 1
    }
    local version
    version=$(printf '%s' "$response" | grep -o '"tag_name": *"[^"]*"' | cut -d'"' -f4 | sed 's/^v//')

    if [[ -z "$version" ]]; then
        echo "Error: Could not parse version from response" >&2
        return 1
    fi

    printf '%s\n' "$version"
}

function download_file() {
    local url="${1:?Usage: download_file <url>}"
    local file_name=${2:-$(basename $url)}
    local cache_dir="/tmp/bootstrap_cache"
    mkdir -p "$cache_dir"
    local file_path="${cache_dir}/${file_name}"
    if ! curl -fsSL "$url" -o "$file_path"; then
        echo "Error: Failed to download '${file_name}' from '${url}'" >&2
        return 1
    fi
    echo "$file_path"
}


function debug() {
    if [[ "${DEBUG:-0}" == "1" ]]; then
        echo "$(date +'%Y-%m-%d %H:%M:%S') [DEBUG] $*" >&2
    fi
}

install_pip_tool() {
    # Ensure an argument was passed
    if [[ -z "${1:-}" ]]; then
        echo "Error: No tool name provided to install_pip_tool." >&2
        return 1
    fi

    local tool_name="$1"

    # 1. Correct the dependency check and error message
    if ! command -v pipx &> /dev/null; then
        echo "Error: pipx is not installed. Please install pipx first." >&2
        return 1 # Use return inside functions, not exit (so it doesn't close your whole terminal)
    fi

    # 2. Reinstall cleanly using --force
    echo "Installing/Updating $tool_name via pipx..."
    if pipx install --force "$tool_name"; then
        echo "Successfully installed $tool_name"
    else
        echo "Error: Failed to install $tool_name" >&2
        return 1
    fi
}

install_npm_tool() {
    # Ensure an argument was passed
    if [[ -z "${1:-}" ]]; then
        echo "Error: No tool name provided to install_npm_tool." >&2
        return 1
    fi

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    local tool_name="$1"

    # 1. Check for npm and provide a clear error message if it's not found
    if ! command -v npm &> /dev/null; then
        echo "Error: npm is not installed. Please install Node.js and npm first." >&2
        return 1
    fi

    # 2. Install the tool globally using npm
    if npm list -g "$tool_name" &>/dev/null; then
        echo "Updating ${tool_name}..."
    else
        echo "Installing ${tool_name}..."
    fi

    if npm install -g "$tool_name"; then
        echo "Done: ${tool_name}"
    else
        echo "Error: Failed to install/update ${tool_name}" >&2
        return 1
    fi
}

function install_dotnet_tool() {
    # Ensure an argument was passed
    if [[ -z "${1:-}" ]]; then
        echo "Error: No tool name provided to install_dotnet_tool." >&2
        return 1
    fi

    local tool_name="$1"
    local dotnet_path="$HOME/.dotnet/dotnet"
    if ! command -v "$dotnet_path" &> /dev/null; then
        echo "Error: dotnet is not installed. Please install dotnet first." >&2
        return 1
    fi
    if $HOME/.dotnet/dotnet tool list -g $tool_name >/dev/null 2>&1; then
        $HOME/.dotnet/dotnet tool update -g $tool_name
        echo "Updated $tool_name"
    else
        $HOME/.dotnet/dotnet tool install -g $tool_name
        echo "Installed $tool_name"
    fi
}

function install_dotnet_template() {
    # Ensure an argument was passed
    if [[ -z "${1:-}" ]]; then
        echo "Error: No template name provided to install_dotnet_template." >&2
        return 1
    fi

    local template_name="$1"
    local dotnet_path="$HOME/.dotnet/dotnet"
    if ! command -v "$dotnet_path" &> /dev/null; then
        echo "Error: dotnet is not installed. Please install dotnet first." >&2
        return 1
    fi
    if $HOME/.dotnet/dotnet tool list -g $template_name >/dev/null 2>&1; then
        return 0
    else
        $HOME/.dotnet/dotnet new install $template_name
        echo "Installed $template_name"
    fi
}

install_go_tool() {
    if [[ -z "${1:-}" ]]; then
        echo "Error: No repository URL provided to install_go_tool." >&2
        return 1
    fi

    local repo="$1"
    local default_tool_name
    default_tool_name=$(basename "$repo")
    default_tool_name="${default_tool_name%@*}"
    
    # Fallback to the extracted repository name if a second argument isn't provided
    local binary_name="${2:-$default_tool_name}"
    local is_global="${3:-false}"
    echo "Determined binary name: $binary_name from repo: $repo"

    # Fallback paths mirroring your configuration
    local go_root="${GOROOT:-/opt/go}"
    local go_path="${GOPATH:-$HOME/projects/go}"
    
    # 1. Declare local variables that we want to export safely to sub-processes
    local -x GOBIN="${GOBIN:-$go_path/bin}"
    local -x GOPATH="$go_path"
    
    # Ensure the target installation directory exists
    mkdir -p "$GOBIN"

    # Check if go is available, checking your custom GOROOT if needed
    if ! command -v go &> /dev/null; then
        if [[ -x "$go_root/bin/go" ]]; then
            local -x PATH="$go_root/bin:$PATH"
        else
            echo "Error: Go binary not found in PATH or at $go_root/bin." >&2
            return 1
        fi
    fi

    # Append @latest only if you haven't pinned a specific version string
    local target_repo="$repo"
    if [[ "$repo" != *@* ]]; then
        target_repo="${repo}@latest"
    fi

    echo "Installing $binary_name via go install..."
    if go install "$target_repo"; then
        if [[ "$is_global" == "true" ]]; then
            sudo mv "$GOBIN/$binary_name" "/usr/local/bin/$binary_name"
            echo "Installed $binary_name globally at: $(which $binary_name)"
        else
            echo "Installed $binary_name locally at: $GOBIN/$binary_name"
        fi
    else
        echo "Error: Failed to install $binary_name via Go." >&2
        return 1
    fi
}

install_cargo_tool() {
    if [[ -z "${1:-}" ]]; then
        echo "Error: No crate/tool name provided to install_cargo_tool." >&2
        return 1
    fi

    local tool_name="$1"
    local binary_name="${2:-$tool_name}"
    local is_global="${3:-false}"
    local force_update="${4:-false}"
    
    # Force define CARGO_HOME for this function if it isn't set globally
    local cargo_home="${CARGO_HOME:-$HOME/.cargo}"
    local cargo_bin="$cargo_home/bin"

    # 1. Declare local variables that we want to export safely to sub-processes
    local -x CARGO_HOME="$cargo_home"

    # If cargo isn't in PATH, try looking for it in the expected fallback location
    if ! command -v cargo &> /dev/null; then
        if [[ -x "$cargo_bin/cargo" ]]; then
            local -x PATH="$cargo_bin:$PATH"
        else
            echo "Error: Cargo could not be found globally or at $cargo_bin." >&2
            return 1
        fi
    fi

    # Check if already installed; skip unless force_update is requested
    if command -v "$binary_name" &> /dev/null && [[ "$force_update" != "true" ]]; then
        echo "$tool_name is already installed at: $(command -v $binary_name). Skipping."
        return 0
    fi

    local cargo_flags="-q --locked"
    if [[ "$force_update" == "true" ]]; then
        cargo_flags="$cargo_flags --force"
    fi

    echo "Installing $tool_name via Cargo..."
    # shellcheck disable=SC2086
    if cargo install $cargo_flags "$tool_name"; then
        if [[ "$is_global" == "true" ]]; then
            sudo mv "$cargo_bin/$binary_name" "/usr/local/bin/$binary_name"
            echo "Installed $tool_name globally at: $(command -v $binary_name)"
        else
            echo "Installed $tool_name locally at: $cargo_bin/$binary_name"
        fi
    else
        echo "Error: Failed to install $tool_name via Cargo." >&2
        return 1
    fi
}