#!/usr/bin/env bash
set -euo pipefail

_packages=(
  git
  curl
  build-essential
  g++
  gdb
  apt-transport-https
  # ncdu (NCurses Disk Usage) is a disk utility for Unix systems
  # https://github.com/rofl0r/ncdu
  "ncdu"
  # A command-line program for getting and setting the contents of the X selection
  # https://github.com/kfish/xsel
  "xsel"
  # Command line interface to the X11 clipboard
  # https://github.com/astrand/xclip
  "xclip"
  "zip"
  "unzip"
  "cmake"
  "ca-certificates"
  "jq"
  "htop"
  # Stow is a symlink farm manager program which takes distinct sets of software and/or data located in separate directories on the filesystem, and makes them all appear to be installed in a single directory tree.
  # https://github.com/aspiers/stow
  "stow"
  "vim"
  "tk-dev" # Tk is a cross-platform graphical toolkit which provides the Motif look-and-feel and is implemented using the Tcl scripting language. needed for tkinter package
  "libssl-dev" # needed for openssl development and to build python from source with ssl support
)

_networking_packages=(
  "bind9-dnsutils"
  "nmap"
  "traceroute"
  # MTR is a simple, cross-platform command-line network diagnostic tool that combines the functionality of commonly used traceroute and ping programs into a single tool
  "mtr"
  "whois"
  "net-tools"
)

sudo apt install ${_packages[@]} -y
sudo apt install ${_networking_packages[@]} -y