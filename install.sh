#!/bin/bash

set -e

# ── Colors ───────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
info()    { echo -e "${BLUE}→${NC}  $1"; }
success() { echo -e "${GREEN}✓${NC}  $1"; }
warn()    { echo -e "${YELLOW}!${NC}  $1"; }
die()     { echo -e "${RED}✗${NC}  $1"; exit 1; }

DOTFILES="${DOTFILES:-$HOME/.config}"

echo ""
echo "  dotfiles install"
echo "  ════════════════"
echo ""

# ── Homebrew ─────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add brew to PATH for the rest of this script
  [[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
  [[ -f /usr/local/bin/brew   ]] && eval "$(/usr/local/bin/brew shellenv)"
  success "Homebrew installed"
else
  success "Homebrew already installed"
fi

# ── Brew Bundle ──────────────────────────────────────────────────────────────
BREWFILE="$DOTFILES/brew/Brewfile"
if [[ -f "$BREWFILE" ]]; then
  info "Installing packages from Brewfile..."
  brew bundle --file="$BREWFILE"
  success "Packages installed"
else
  warn "No Brewfile found at $BREWFILE — skipping"
fi

# ── Git Submodules (zsh plugins) ─────────────────────────────────────────────
if [[ -d "$DOTFILES/.git" ]]; then
  info "Initializing git submodules..."
  git -C "$DOTFILES" submodule update --init --recursive
  success "Submodules initialized"
else
  warn "$DOTFILES is not a git repo — skipping submodule init"
fi

# ── .zshenv symlink ───────────────────────────────────────────────────────────
ZSHENV_SRC="$DOTFILES/.zshenv"
ZSHENV_DST="$HOME/.zshenv"

if [[ -L "$ZSHENV_DST" ]]; then
  success "~/.zshenv symlink already in place"
elif [[ -f "$ZSHENV_DST" ]]; then
  warn "~/.zshenv already exists as a regular file — backing up to ~/.zshenv.bak"
  mv "$ZSHENV_DST" "$ZSHENV_DST.bak"
  ln -s "$ZSHENV_SRC" "$ZSHENV_DST"
  success "Symlinked ~/.zshenv → $ZSHENV_SRC"
else
  ln -s "$ZSHENV_SRC" "$ZSHENV_DST"
  success "Symlinked ~/.zshenv → $ZSHENV_SRC"
fi

# ── Default shell ─────────────────────────────────────────────────────────────
ZSH_PATH="$(command -v zsh)"
if [[ "$SHELL" != "$ZSH_PATH" ]]; then
  info "Setting zsh as default shell..."
  # Add to /etc/shells if not already there
  if ! grep -q "$ZSH_PATH" /etc/shells; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells
  fi
  chsh -s "$ZSH_PATH"
  success "Default shell set to zsh ($ZSH_PATH)"
else
  success "zsh is already the default shell"
fi

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
echo -e "  ${GREEN}All done!${NC} Restart your terminal to apply everything."
echo ""
