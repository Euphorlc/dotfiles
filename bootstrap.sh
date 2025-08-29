#!/bin/bash

set -e  # Exit on error
set -u  # Error on undefined variables

# --- Configuration ---
DOTFILES_DIR="$HOME/dotfiles"
REPO_URL="https://github.com/Euphorlc/dotfiles.git"

# --- Install GNU Stow ---
if ! command -v stow >/dev/null 2>&1; then
  echo "[*] Installing GNU Stow..."
  if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install stow
  elif [[ -f /etc/debian_version ]]; then
    sudo apt update -qq && sudo apt install -y -qq stow
  elif [[ -f /etc/redhat-release ]]; then
    sudo dnf install -y -q stow
  else
    echo "Please install GNU Stow manually."
    exit 1
  fi
fi

# --- Install Fish Shell ---
if ! command -v fish >/dev/null 2>&1; then
  echo "[*] Installing Fish Shell..."
  if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install fish
  elif [[ -f /etc/debian_version ]]; then
    sudo apt update -qq && sudo apt install -y -qq fish
  elif [[ -f /etc/redhat-release ]]; then
    sudo dnf install -y -q fish
  else
    echo "Please install Fish Shell manually."
    exit 1
  fi
fi

# --- Set Fish as default shell ---
FISH_BIN="$(command -v fish)"
if [[ -n "$FISH_BIN" ]]; then
  echo "[*] Setting Fish as default shell..."
  chsh -s "$FISH_BIN"
else
  echo "[!] Fish binary not found. Cannot set default shell."
fi

# --- Install Starship
echo "[*] Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

# --- Clone the dotfiles repo if it doesn't exist ---
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "[*] Cloning dotfiles into $DOTFILES_DIR"
  git clone -q "$REPO_URL" "$DOTFILES_DIR"
fi

# --- Run stow to create symlinks ---
cd "$DOTFILES_DIR"
echo "[*] Stowing Dotfiles"
stow .

echo "[✓] Bootstrap complete!"

fish