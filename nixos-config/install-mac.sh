#!/usr/bin/env bash
# =============================================================================
# macOS First-Time Setup Script for nix-darwin + home-manager
# =============================================================================
#
# PREREQUISITES (must be done manually before running this script):
#   1. Install Determinate Systems Nix:
#      curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
#   2. Open a NEW terminal session after Nix is installed so it is on your PATH.
#
# USAGE:
#   chmod +x install-mac.sh && ./install-mac.sh
#
# What this script does:
#   1. Detects your Mac architecture (Apple Silicon / Intel)
#   2. Clones this config repo to ~/Documents/Github/config_files
#   3. Installs nix-darwin and applies the darwin configuration (Noir / IntelMac)
#   4. Applies the home-manager configuration (ishaan@Noir)
# =============================================================================

set -euo pipefail

# ─── Colours ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

log()   { echo -e "${GREEN}[$(date +'%H:%M:%S')]${NC} $*"; }
info()  { echo -e "${BLUE}[INFO]${NC}  $*"; }
warn()  { echo -e "${YELLOW}[WARN]${NC}  $*"; }
error() { echo -e "${RED}[ERROR]${NC} $*" >&2; exit 1; }
step()  { echo -e "\n${CYAN}${BOLD}━━━ $* ━━━${NC}\n"; }

# ─── Banner ───────────────────────────────────────────────────────────────────
echo ""
echo -e "${CYAN}${BOLD}"
echo "  ███╗   ██╗██╗██╗  ██╗      ██████╗  █████╗ ██████╗ ██╗    ██╗██╗███╗   ██╗"
echo "  ████╗  ██║██║╚██╗██╔╝      ██╔══██╗██╔══██╗██╔══██╗██║    ██║██║████╗  ██║"
echo "  ██╔██╗ ██║██║ ╚███╔╝ █████╗██║  ██║███████║██████╔╝██║ █╗ ██║██║██╔██╗ ██║"
echo "  ██║╚██╗██║██║ ██╔██╗ ╚════╝██║  ██║██╔══██║██╔══██╗██║███╗██║██║██║╚██╗██║"
echo "  ██║ ╚████║██║██╔╝ ██╗      ██████╔╝██║  ██║██║  ██║╚███╔███╔╝██║██║ ╚████║"
echo "  ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝"
echo -e "${NC}"
echo -e "  ${BOLD}macOS Bootstrap — nix-darwin + home-manager${NC}"
echo ""

# ─── Configuration ────────────────────────────────────────────────────────────
GITHUB_REPO="https://github.com/ishaan26/config_files"
CONFIG_REPO_DIR="$HOME/Documents/Github/config_files"
FLAKE_DIR="$CONFIG_REPO_DIR/nixos-config"
# The Nix/home-manager config uses 'ishaan' as the user — keep this in sync with your flake
NIX_USERNAME="ishaan"

# ─── Preflight checks ─────────────────────────────────────────────────────────
step "Preflight checks"

# Must NOT be root
if [[ $EUID -eq 0 ]]; then
  error "Do not run this script as root. Run it as your regular user account."
fi

# Nix must be available
if ! command -v nix &>/dev/null; then
  echo ""
  error "Nix is not installed or not on your PATH.

Please install Determinate Systems Nix first:

  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

Then open a new terminal and re-run this script."
fi

NIX_VERSION=$(nix --version 2>&1 || true)
log "Nix found: $NIX_VERSION"

# Git must be available (Xcode CLT)
if ! command -v git &>/dev/null; then
  error "git is not found. Install Xcode Command Line Tools first:
  xcode-select --install"
fi
log "git found: $(git --version)"

# Network check
if ! curl -fsSL --max-time 5 https://github.com &>/dev/null; then
  error "Cannot reach github.com — check your network connection."
fi
log "Network OK"

# ─── Detect architecture ──────────────────────────────────────────────────────
step "Detecting architecture"

ARCH=$(uname -m)
if [[ "$ARCH" == "arm64" ]]; then
  DARWIN_CONFIG="Noir"
  HOME_CONFIG="ishaan@Noir"
  NIX_SYSTEM="aarch64-darwin"
  info "Apple Silicon Mac detected → using config: ${BOLD}$DARWIN_CONFIG${NC}"
elif [[ "$ARCH" == "x86_64" ]]; then
  DARWIN_CONFIG="IntelMac"
  HOME_CONFIG="ishaan@Noir"   # home config is shared
  NIX_SYSTEM="x86_64-darwin"
  info "Intel Mac detected → using config: ${BOLD}$DARWIN_CONFIG${NC}"
else
  error "Unknown architecture: $ARCH"
fi

# ─── Summary ──────────────────────────────────────────────────────────────────
echo ""
echo -e "  ${BOLD}Installation plan:${NC}"
echo -e "  • Clone repo to   : ${CYAN}$CONFIG_REPO_DIR${NC}"
echo -e "  • Darwin config   : ${CYAN}$DARWIN_CONFIG${NC}"
echo -e "  • Home config     : ${CYAN}$HOME_CONFIG${NC}"
echo -e "  • Architecture    : ${CYAN}$NIX_SYSTEM${NC}"
echo ""
read -rp "$(echo -e "${BOLD}  Proceed? [y/N]: ${NC}")" CONFIRM
[[ "$(echo "$CONFIRM" | tr '[:upper:]' '[:lower:]')" == "y" ]] || { echo "Aborted."; exit 0; }

# ─── Clone / update repo ──────────────────────────────────────────────────────
step "Setting up config repository"

if [[ -d "$FLAKE_DIR" ]]; then
  warn "Config directory already exists at $FLAKE_DIR"
  read -rp "$(echo -e "${YELLOW}  Pull latest changes? [y/N]: ${NC}")" PULL_CONFIRM
  if [[ "$(echo "$PULL_CONFIRM" | tr '[:upper:]' '[:lower:]')" == "y" ]]; then
    log "Pulling latest changes..."
    git -C "$CONFIG_REPO_DIR" pull --ff-only
  else
    info "Skipping git pull — using existing repo."
  fi
else
  log "Cloning $GITHUB_REPO → $CONFIG_REPO_DIR"
  mkdir -p "$(dirname "$CONFIG_REPO_DIR")"
  git clone "$GITHUB_REPO" "$CONFIG_REPO_DIR"
fi

[[ -f "$FLAKE_DIR/flake.nix" ]] || error "flake.nix not found at $FLAKE_DIR/flake.nix"
log "Flake found at $FLAKE_DIR"

# ─── Install/Apply nix-darwin ──────────────────────────────────────────────────
step "Applying nix-darwin configuration"

log "Building nix-darwin system configuration..."
nix build \
  --extra-experimental-features "nix-command flakes" \
  "$FLAKE_DIR#darwinConfigurations.$DARWIN_CONFIG.system"

log "Activating system configuration (requires sudo)..."
sudo ./result/sw/bin/darwin-rebuild switch --flake "$FLAKE_DIR#$DARWIN_CONFIG"

log "Cleaning up build symlink..."
rm -f ./result

# ─── Apply home-manager config ────────────────────────────────────────────────
step "Applying home-manager configuration"

if command -v nh &>/dev/null; then
  log "Using installed nh to activate home-manager configuration..."
  nh home switch "$FLAKE_DIR" --username "$NIX_USERNAME"
else
  log "nh not found in PATH. Running home-manager setup using nh via nix run..."
  nix run \
    --extra-experimental-features "nix-command flakes" \
    "nixpkgs#nh" -- \
    home switch "$FLAKE_DIR" --username "$NIX_USERNAME"
fi

# ─── Done ─────────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}${BOLD}"
echo "  ╔════════════════════════════════════════════════╗"
echo "  ║         Setup complete! 🎉                     ║"
echo "  ╚════════════════════════════════════════════════╝"
echo -e "${NC}"
echo -e "  ${BOLD}Next steps:${NC}"
echo ""
echo -e "  1. ${CYAN}Restart your shell${NC} (or open a new terminal tab)"
echo -e "     Your default shell has been changed to fish."
echo ""
echo -e "  2. ${CYAN}Log out and back in${NC} to apply all macOS system defaults"
echo -e "     (Dock, Finder, keyboard settings, etc.)"
echo ""
echo -e "  3. Your config lives at:"
echo -e "     ${CYAN}$FLAKE_DIR${NC}"
echo -e "     Update it anytime and re-apply with: ${BOLD}nh os switch${NC}"
echo ""
