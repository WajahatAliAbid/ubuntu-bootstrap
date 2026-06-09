#!/usr/bin/env bash
set -euo pipefail

source ./scripts/_helpers.sh

# ─── Sections ────────────────────────────────────────────────────────────────

section_languages=(
  ./scripts/languages/python.sh
  ./scripts/languages/nodejs.sh
)

section_pip_tools=(
  ./scripts/languages/tools/python/uv.sh
  ./scripts/languages/tools/python/hatch.sh
  ./scripts/languages/tools/python/ruff.sh
  ./scripts/languages/tools/python/tldr.sh
)

section_tools=(
  ./scripts/tools/pyenv.sh
  ./scripts/tools/tfenv.sh
  ./scripts/tools/docker.sh
  ./scripts/tools/awscli.sh
  ./scripts/tools/postgresql.sh
  ./scripts/tools/github_cli.sh
  ./scripts/tools/cloc.sh
  ./scripts/tools/claude.sh
  ./scripts/tools/btop.sh
  "${section_pip_tools[@]}"
)

section_programs=(
  ./scripts/programs/chrome.sh
  ./scripts/programs/vscode.sh
  ./scripts/programs/slack.sh
  ./scripts/programs/remmina.sh
  ./scripts/programs/mpv.sh
  ./scripts/programs/libreoffice.sh
  ./scripts/programs/obs_studio.sh
  ./scripts/programs/krita.sh
  ./scripts/programs/pgadmin.sh
  ./scripts/programs/partition_manager.sh
)

section_core=(
  ./scripts/config.sh
  ./scripts/core_packages.sh
)

section_all=(
  "${section_core[@]}"
  "${section_languages[@]}"
  "${section_tools[@]}"
  "${section_programs[@]}"
)

# ─── Runner ──────────────────────────────────────────────────────────────────

run_section() {
  local update="$1"
  shift
  local scripts=("$@")

  for script in "${scripts[@]}"; do
    if [[ ! -f "$script" ]]; then
      echo "⚠  Skipping $script (not found)"
      continue
    fi
    if [[ "$update" == "1" ]] && ! grep -q "meta:update: true" "$script" 2>/dev/null; then
      echo "⏭  Skipping $script (not marked for update)"
      continue
    fi
    echo "▶  Running $script"
    bash "$script"
  done
}

# ─── CLI ─────────────────────────────────────────────────────────────────────

usage() {
  cat <<EOF
Usage: $(basename "$0") <command> [options]

Commands:
  install     Run full installation (core + languages + tools + programs)
  update      Re-run scripts marked with meta:update: true

Options:
  -u, --update            Run OS updates before executing scripts
  -h, --help              Show this help message

Examples:
  $(basename "$0") install
  $(basename "$0") install --update
  $(basename "$0") update
EOF
}

# ─── Parse args ──────────────────────────────────────────────────────────────

COMMAND="${1:-}"
if [[ -z "$COMMAND" || "$COMMAND" == "-h" || "$COMMAND" == "--help" ]]; then
  usage
  exit 0
fi
shift

OS_UPDATE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    -u|--update)   OS_UPDATE=1; shift ;;
    -h|--help)     usage; exit 0 ;;
    *) echo "❌ Unknown option: $1"; usage; exit 1 ;;
  esac
done

# ─── OS Updates ──────────────────────────────────────────────────────────────

if [[ $OS_UPDATE -eq 1 ]]; then
  echo "🔄 Running OS updates before executing scripts"
  bash ./scripts/run_updates.sh
fi

# ─── Dispatch ────────────────────────────────────────────────────────────────

case "$COMMAND" in
  install)
    echo "🚀 Setting up Ubuntu system"
    run_section 0 "${section_all[@]}"
    ;;

  update)
    echo "🔄 Updating system"
    run_section 1 "${section_all[@]}"
    ;;

  *)
    echo "❌ Unknown command: $COMMAND"
    usage
    exit 1
    ;;
esac
