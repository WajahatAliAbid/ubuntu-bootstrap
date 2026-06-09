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

