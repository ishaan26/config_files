#!/usr/bin/env bash
set -e

# NixOS Automated Installation Script for Production Systems
# This script automates the installation of NixOS from a GitHub flake config

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log() {
  echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

error() {
  echo -e "${RED}[ERROR]${NC} $1"
  exit 1
}

# FIXME: Make this script runable
error "script does not work. DO NOT USE IT"!

warn() {
  echo -e "${YELLOW}[WARNING]${NC} $1"
}

info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

# Configuration
GITHUB_REPO="https://github.com/ishaan26/config_files"
CONFIG_PATH="nixos-config"
HOSTNAME="nixos" # Change to match your flake configuration

# Check if we're running as root
if [[ $EUID -ne 0 ]]; then
  error "This script must be run as root (use sudo)"
fi

# Banner
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║         NixOS Production Installation Script               ║"
echo "║                                                            ║"
echo "║  This will install NixOS from your GitHub flake config     ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Test network connectivity
log "Testing network connectivity..."
if ! ping -c 1 nixos.org &>/dev/null; then
  error "No network connectivity. Please check your network settings."
fi
info "Network OK"
echo ""

# Display available disks
log "Available disks:"
lsblk -d -o NAME,SIZE,TYPE,MODEL | grep disk
echo ""

# Select disk
while true; do
  read -p "Enter the disk to install to (e.g., sda, nvme0n1, vda): " DISK_NAME
  DISK="/dev/${DISK_NAME}"

  if [ ! -b "$DISK" ]; then
    error "Disk ${DISK} does not exist. Please try again."
    continue
  fi

  echo ""
  warn "⚠️  WARNING: ALL DATA ON ${DISK} WILL BE DESTROYED! ⚠️"
  lsblk "$DISK"
  echo ""
  read -p "Are you absolutely sure you want to use ${DISK}? (type 'YES' to confirm): " CONFIRM

  if [ "$CONFIRM" = "YES" ]; then
    break
  else
    echo "Disk selection cancelled. Please choose again."
    echo ""
  fi
done

# Ask for partition scheme
echo ""
info "Select partition scheme:"
echo "  1) UEFI (modern systems)"
echo "  2) BIOS/Legacy"
read -p "Enter choice [1-2]: " BOOT_MODE

case $BOOT_MODE in
1)
  BOOT_TYPE="UEFI"
  ;;
2)
  BOOT_TYPE="BIOS"
  ;;
*)
  error "Invalid choice"
  ;;
esac

# Ask for swap size
echo ""
read -p "Enter swap size in GB (0 for no swap, recommended: 8-16): " SWAP_SIZE
if ! [[ "$SWAP_SIZE" =~ ^[0-9]+$ ]]; then
  error "Invalid swap size"
fi

# Ask for hostname
echo ""
read -p "Enter hostname for this system [${HOSTNAME}]: " INPUT_HOSTNAME
if [ -n "$INPUT_HOSTNAME" ]; then
  HOSTNAME="$INPUT_HOSTNAME"
fi

# Ask for username
echo ""
read -p "Enter your primary username for the new system [ishaan]: " INPUT_USER
TARGET_USER=${INPUT_USER:-ishaan}

# Final confirmation
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                Installation Summary                        ║"
echo "╠════════════════════════════════════════════════════════════╣"
printf "║ Disk:          %-40s ║\n" "$DISK"
printf "║ Boot Mode:     %-40s ║\n" "$BOOT_TYPE"
printf "║ Swap Size:     %-40s ║\n" "${SWAP_SIZE}GB"
printf "║ Hostname:      %-40s ║\n" "$HOSTNAME"
printf "║ Config Repo:   %-40s ║\n" "$GITHUB_REPO"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
read -p "Proceed with installation? (type 'YES' to continue): " FINAL_CONFIRM

if [ "$FINAL_CONFIRM" != "YES" ]; then
  error "Installation cancelled"
fi

# Partition the disk
log "Partitioning ${DISK}..."

if [ "$BOOT_TYPE" = "UEFI" ]; then
  parted "$DISK" -- mklabel gpt
  parted "$DISK" -- mkpart ESP fat32 1MiB 512MiB
  parted "$DISK" -- set 1 esp on

  if [ "$SWAP_SIZE" -gt 0 ]; then
    SWAP_END=$((512 + SWAP_SIZE * 1024))
    parted "$DISK" -- mkpart primary linux-swap 512MiB ${SWAP_END}MiB
    parted "$DISK" -- mkpart primary ${SWAP_END}MiB 100%
    BOOT_PART="${DISK}1"
    SWAP_PART="${DISK}2"
    ROOT_PART="${DISK}3"
  else
    parted "$DISK" -- mkpart primary 512MiB 100%
    BOOT_PART="${DISK}1"
    ROOT_PART="${DISK}2"
  fi
else
  # BIOS/Legacy
  parted "$DISK" -- mklabel msdos
  parted "$DISK" -- mkpart primary 1MiB 512MiB
  parted "$DISK" -- set 1 boot on

  if [ "$SWAP_SIZE" -gt 0 ]; then
    SWAP_END=$((512 + SWAP_SIZE * 1024))
    parted "$DISK" -- mkpart primary linux-swap 512MiB ${SWAP_END}MiB
    parted "$DISK" -- mkpart primary ${SWAP_END}MiB 100%
    BOOT_PART="${DISK}1"
    SWAP_PART="${DISK}2"
    ROOT_PART="${DISK}3"
  else
    parted "$DISK" -- mkpart primary 512MiB 100%
    BOOT_PART="${DISK}1"
    ROOT_PART="${DISK}2"
  fi
fi

# Handle NVMe naming convention
if [[ "$DISK" == *"nvme"* ]]; then
  BOOT_PART="${DISK}p1"
  if [ "$SWAP_SIZE" -gt 0 ]; then
    SWAP_PART="${DISK}p2"
    ROOT_PART="${DISK}p3"
  else
    ROOT_PART="${DISK}p2"
  fi
fi

sleep 2 # Wait for kernel to recognize partitions

log "Formatting partitions..."
if [ "$BOOT_TYPE" = "UEFI" ]; then
  mkfs.fat -F 32 -n boot "$BOOT_PART"
else
  mkfs.ext4 -L boot "$BOOT_PART"
fi

mkfs.ext4 -L nixos "$ROOT_PART"

if [ "$SWAP_SIZE" -gt 0 ]; then
  mkswap -L swap "$SWAP_PART"
  swapon "$SWAP_PART"
  info "Swap enabled"
fi

log "Mounting filesystems..."
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot

# Generate hardware configuration
log "Generating hardware configuration..."
nixos-generate-config --root /mnt

# Set up Git and Nix with flakes
log "Setting up environment with Git and Flakes..."
nix-shell -p git nixFlakes --command "bash -c '

# Define colors for inner script
GREEN=\"\\033[0;32m\"
RED=\"\\033[0;31m\"
NC=\"\\033[0m\"

log() { echo -e \"\${GREEN}[\$(date +\"%Y-%m-%d %H:%M:%S\")]\${NC} \$1\"; }
error() { echo -e \"\${RED}[ERROR]\${NC} \$1\"; exit 1; }

TARGET_USER=\"${TARGET_USER}\"
REPO_DIR=\"/mnt/home/\${TARGET_USER}/Documents/Github/config_files\"
CONFIG_SRC=\"\${REPO_DIR}/${CONFIG_PATH}\"

log \"Cloning configuration to \${REPO_DIR}...\"

# Create directory structure
mkdir -p \"\$(dirname \"\$REPO_DIR\")\"

# Clone repo
git clone ${GITHUB_REPO} \"\$REPO_DIR\"

if [ ! -d \"\$CONFIG_SRC\" ]; then
    error \"Config path ${CONFIG_PATH} not found in repository\"
fi

# Copy hardware-configuration.nix to the config directory
log \"Copying generated hardware-configuration.nix...\"
cp /mnt/etc/nixos/hardware-configuration.nix \"\$CONFIG_SRC/\"

# Create symlinks from /etc/nixos to the config directory
log \"Creating symlinks...\"
rm -rf /mnt/etc/nixos/*
ln -sf \"\$CONFIG_SRC\"/* /mnt/etc/nixos/

# Fix permissions (assuming UID 1000:100 for primary user/group)
log \"Setting permissions for user \${TARGET_USER}...\"
chown -R 1000:100 \"/mnt/home/\${TARGET_USER}\"

log \"Symlinks created:\"
ls -la /mnt/etc/nixos/

# Verify flake.nix exists
if [ ! -f /mnt/etc/nixos/flake.nix ]; then
    error \"flake.nix not found in the configuration\"
fi

log \"Configuration setup complete\"
'
"

# Show flake outputs
log "Available flake configurations:"
nix-shell -p nixFlakes --command "cd /mnt/etc/nixos && nix flake show 2>/dev/null || echo 'Could not show flake outputs'"

echo ""
info "The script will install using: nixosConfigurations.${HOSTNAME}"
warn "If your flake uses a different name, press Ctrl+C now and update HOSTNAME in the script"
echo ""
read -p "Press Enter to continue with installation..."

# Install NixOS
log "Installing NixOS from flake..."
echo ""
nixos-install --flake "/mnt/etc/nixos#${HOSTNAME}"

# Success message
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║              Installation Complete! 🎉                     ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
info "Your NixOS configuration is symlinked from /etc/nixos"
info "Hardware configuration is stored in your config directory"
echo ""
echo "Next steps:"
echo "  1. Set root password if not already set"
echo "  2. Reboot: type 'reboot'"
echo "  3. Remove installation media"
echo "  4. After boot, your config files will be at /etc/nixos"
echo ""
read -p "Press Enter to continue..."
