#!/bin/bash

# Define color codes - using simple variables instead of associative array
STD='\033[0;0;39m'
NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'

# Script version
VERSION="1.0.0"

# Logging function
log() {
    local level=$1
    shift
    local message=$*
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    case $level in
    "INFO") color=$GREEN ;;
    "WARNING") color=$YELLOW ;;
    "ERROR") color=$RED ;;
    *) color=$STD ;;
    esac
    echo -e "${color}[$timestamp] [$level] $message${NONE}"
    # Also log to file
    echo "[$timestamp] [$level] $message" >>install.log
}

# Error handling
set -e
trap 'handle_error $? $LINENO $BASH_LINENO "$BASH_COMMAND" $(printf "::%s" ${FUNCNAME[@]:-})' ERR

handle_error() {
    local exit_code=$1
    local line_no=$2
    local bash_lineno=$3
    local last_command=$4
    local func_trace=$5
    log "ERROR" "Command '$last_command' failed with exit code $exit_code at line $line_no"
    log "ERROR" "Function trace: $func_trace"
}

# Check for root privileges when needed
check_root() {
    if [[ $EUID -ne 0 ]]; then
        log "ERROR" "This operation requires root privileges"
        sudo "$0" "$@"
        exit $?
    fi
}

# System detection with more detail
detect_system() {
    if [ -f /etc/os-release ]; then
        # freedesktop.org and systemd
        . /etc/os-release
        OS=$NAME
    elif type lsb_release >/dev/null 2>&1; then
        # linuxbase.org
        OS=$(lsb_release -si)
    elif [ -f /etc/lsb-release ]; then
        # For some versions of Debian/Ubuntu without lsb_release command
        . /etc/lsb-release
        OS=$DISTRIB_ID
    elif [ -f /etc/debian_version ]; then
        # Older Debian/Ubuntu/etc.
        OS=Debian
    else
        # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
        OS=$(uname -s)
    fi

    KERNEL=$(uname -r)
    ARCH=$(uname -m)

    case "$OS" in
    "Arch Linux" | "Manjaro Linux" | "CachyOS Linux")
        CPU=$(grep "model name" /proc/cpuinfo | head -n1 | cut -d ":" -f2 | sed 's/^[ \t]*//')
        MEMORY=$(free -h | awk '/^Mem:/ {print $2}')
        ;;
    "Darwin")
        CPU=$(sysctl -n machdep.cpu.brand_string)
        MEMORY=$(sysctl -n hw.memsize | awk '{printf "%.2f GB\n", $1 / (1024^3)}')
        ;;
    esac

    # Check for supported systems
    case "$OS" in
    "Arch Linux" | "Manjaro Linux" | "Darwin" | "CachyOS Linux")
        log "INFO" "Detected supported system: $OS $VERSION ($ARCH)"
        log "INFO" "Kernel: $KERNEL"
        log "INFO" "CPU: $CPU"
        log "INFO" "Memory: $MEMORY"
        ;;
    *)
        log "ERROR" "Unsupported system: $OS"
        echo -e "${RED} BTW, Why aren't you using Arch? ¯\_(ツ)_/¯${NONE}"
        exit 1
        ;;
    esac
}

# Enhanced menu system with animations
show_menus() {
    local title
    clear
    if [[ "$OS" == "Darwin" ]]; then
        title="
███╗   ███╗ █████╗  ██████╗     ███████╗███████╗████████╗██╗   ██╗██████╗ 
████╗ ████║██╔══██╗██╔════╝     ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗
██╔████╔██║███████║██║          ███████╗█████╗     ██║   ██║   ██║██████╔╝
██║╚██╔╝██║██╔══██║██║          ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝ 
██║ ╚═╝ ██║██║  ██║╚██████╗     ███████║███████╗   ██║   ╚██████╔╝██║     
╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝     ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     
"
    else
        title="
 █████╗ ██████╗  ██████╗██╗  ██╗    ███████╗███████╗████████╗██╗   ██╗██████╗ 
██╔══██╗██╔══██╗██╔════╝██║  ██║    ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗
███████║██████╔╝██║     ███████║    ███████╗█████╗     ██║   ██║   ██║██████╔╝
██╔══██║██╔══██╗██║     ██╔══██║    ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝ 
██║  ██║██║  ██║╚██████╗██║  ██║    ███████║███████╗   ██║   ╚██████╔╝██║     
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     
"
    fi

    # Animate title
    echo -e "${CYAN}"
    echo "$title" | while IFS= read -r line; do
        echo "$line"
        sleep 0.1
    done
    echo -e "${NONE}"

    # Fancy output
    echo -e "${BOLD}${CYAN}==============================="
    echo -e "      System Information      "
    echo -e "===============================${NONE}"
    echo -e "${BOLD}${GREEN}OS:           ${YELLOW}$OS $VERSION${NONE}"
    echo -e "${BOLD}${GREEN}Architecture: ${YELLOW}$ARCH${NONE}"
    echo -e "${BOLD}${GREEN}Kernel:       ${YELLOW}$KERNEL${NONE}"
    echo -e "${BOLD}${GREEN}CPU:          ${YELLOW}$CPU${NONE}"
    echo -e "${BOLD}${GREEN}Memory:       ${YELLOW}$MEMORY${NONE}"
    echo -e "${CYAN}===============================${NONE}"
    echo

    # Menu Header
    echo -e "${CYAN}${BOLD}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
    echo -e "┃                      ${YELLOW}Available Options${CYAN}                     ┃"
    echo -e "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${NONE}"

    # Menu Items
    if [[ "$OS" == "Darwin" ]]; then
        echo -e "${GREEN}${BOLD}  1.${NONE}  Install Packages    ${YELLOW}Set up essential software${NONE}"
        echo -e "${GREEN}${BOLD}  2.${NONE}  Setup Shell         ${YELLOW}Configure your terminal environment${NONE}"
        echo -e "${GREEN}${BOLD}  3.${NONE}  Install Fonts       ${YELLOW}Add custom fonts${NONE}"
        echo -e "${GREEN}${BOLD}  4.${NONE}  Language Tools      ${YELLOW}Install development languages${NONE}"
        echo -e "${GREEN}${BOLD}  5.${NONE}  Cargo Packages      ${YELLOW}Install Rust utilities${NONE}"
        echo -e "${RED}${BOLD}  6.${NONE}  Exit                ${YELLOW}Quit the installer${NONE}"
    else
        echo -e "${GREEN}${BOLD}  1.${NONE} Install Packages     ${YELLOW}Set up essential software${NONE}"
        echo -e "${GREEN}${BOLD}  2.${NONE} Setup Shell          ${YELLOW}Configure your terminal environment${NONE}"
        echo -e "${GREEN}${BOLD}  3.${NONE} Window Manager       ${YELLOW}Install and configure WM${NONE}"
        echo -e "${GREEN}${BOLD}  4.${NONE} Install Fonts        ${YELLOW}Add custom fonts${NONE}"
        echo -e "${GREEN}${BOLD}  5.${NONE} Language Tools       ${YELLOW}Install development languages${NONE}"
        echo -e "${GREEN}${BOLD}  6.${NONE} Cargo Packages       ${YELLOW}Install Rust utilities${NONE}"
        echo -e "${RED}${BOLD}    7.${NONE} Exit                 ${YELLOW}Quit the installer${NONE}"
    fi

    echo
}

# Installation functions would go here, sourced from other files
source ./.setup_scripts/cargo_packages.sh
[[ "$OS" == "Arch Linux" || "$OS" == "Manjaro Linux" ]] && source ./.setup_scripts/arch.sh
[[ "$OS" == "Darwin" ]] && source ./.setup_scripts/mac.sh

# Main program loop
main() {
    detect_system
    while true; do
        show_menus
        local choice
        read -rp "Enter your choice [1-${OS== "Darwin" ? "6" : "7"}]: " choice
        echo

        case $choice in
        1)
            log "INFO" "Starting package installation..."
            install_packages
            ;;
        2)
            log "INFO" "Setting up shell environment..."
            install_shell
            ;;
        3)
            if [[ "$OS" == "Darwin" ]]; then
                log "INFO" "Installing fonts..."
                install_fonts
            else
                log "INFO" "Setting up window manager..."
                install_wm
            fi
            ;;
        4)
            if [[ "$OS" == "Darwin" ]]; then
                log "INFO" "Installing language tools..."
                install_language_tools
            else
                log "INFO" "Installing fonts..."
                install_fonts
            fi
            ;;
        5)
            if [[ "$OS" == "Darwin" ]]; then
                log "INFO" "Installing cargo packages..."
                install_cargo_packages
            else
                log "INFO" "Installing language tools..."
                install_language_tools
            fi
            ;;
        6)
            if [[ "$OS" == "Darwin" ]]; then
                log "INFO" "Exiting..."
                exit 0
            else
                log "INFO" "Installing cargo packages..."
                install_cargo_packages
            fi
            ;;
        7)
            if [[ "$OS" != "Darwin" ]]; then
                log "INFO" "Exiting..."
                exit 0
            fi
            ;;
        *)
            log "WARNING" "Invalid option selected"
            sleep 1
            ;;
        esac
    done
}

# Run the program
main
