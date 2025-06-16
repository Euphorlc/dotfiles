#!/bin/bash

set -e  # Exit on error
set -u  # Error on undefined variables

# --- Configuration ---
DOTFILES_DIR="$HOME/dotfiles"
REPO_URL="https://github.com/Euphorlc/dotfiles.git"

# --- Step 1: Install stow if not present ---
if ! command -v stow >/dev/null 2>&1; then
  echo "[*] Installing GNU Stow..."
  if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install stow
  elif [[ -f /etc/debian_version ]]; then
    sudo apt update && sudo apt install -y -qq stow
  elif [[ -f /etc/redhat-release ]]; then
    sudo dnf install -y -q stow
  else
    echo "Please install GNU Stow manually."
    exit 1
  fi
fi

# --- Step 2: Clone the dotfiles repo if it doesn't exist ---
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "[*] Cloning dotfiles into $DOTFILES_DIR"
  git clone -q "$REPO_URL" "$DOTFILES_DIR"
fi

# --- Step 3: Run stow to create symlinks ---
cd "$DOTFILES_DIR"
echo "[*] Stowing Dotfiles"
stow .

echo "[✓] Bootstrap complete!"