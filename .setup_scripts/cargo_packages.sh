#!/bin/bash
export STD='\033[0;0;39m'
export NONE='\033[00m'
export RED='\033[01;31m'
export GREEN='\033[01;32m'
export YELLOW='\033[01;33m'
export PURPLE='\033[01;35m'
export CYAN='\033[01;36m'
export WHITE='\033[01;37m'
export BOLD='\033[1m'
export UNDERLINE='\033[4m'

pause() {
    read -rp "$*"
}

# Function to check if a package is already installed
check_installed() {
    cargo install --list | grep -q "^$1 v"
    return $?
}

# Function to display a spinner during installation
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    while [ "$(ps a | awk '{print $1}' | grep "$pid")" ]; do
        local temp=${spinstr#?}
        printf " ${CYAN}%c${NONE}" "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b"
    done
    printf "  \b\b"
}

install_cargo_packages() {
    echo -e "\n=> ${BOLD}${GREEN}Installing cargo packages${NONE}\n"

    # Check for rustup
    if ! command -v rustup &>/dev/null; then
        echo -e "${RED}Error: rustup not found!${NONE}"
        echo -e "${YELLOW}Please install language tools first${NONE}"
        pause "Press [Enter] to return to main menu"
        return 1
    fi

    # Define packages in arrays for better organization
    declare -a standard_packages=(
        "lsd"
        "onefetch"
        "bat"
        "procs"
        "ripgrep"
        "mdbook"
        "du-dust"
        "fd-find"
        "hyperfine"
        "tealdeer"
        "viu"
        "git-delta"
        "gping"
        "hexyl"
        "bottom"
        "zoxide"
        "cargo-outdated"
        "cargo-cache"
        "cargo-update"
        "cargo-watch"
        "cargo-tree"
        "cargo-audit"
        "cargo-nextest"
        "gptcommit"
        "topgrade"
    )

    # Count total packages for progress tracking
    total_packages=$((${#standard_packages[@]} + 1)) # +1 for tokei
    current_package=0

    # Create log file
    log_file="/tmp/cargo_install_$(date +%Y%m%d_%H%M%S).log"
    echo "Cargo installation log - $(date)" >"$log_file"

    echo -e "${CYAN}Starting installation of ${#standard_packages[@]} packages...${NONE}"
    echo -e "${YELLOW}Installation logs will be saved to: $log_file${NONE}\n"

    # Install standard packages
    for package in "${standard_packages[@]}"; do
        current_package=$((current_package + 1))
        if check_installed "$package"; then
            echo -e "${GREEN}✓${NONE} $package already installed [${current_package}/${total_packages}]"
            continue
        fi

        echo -e "${YELLOW}Installing${NONE} $package [${current_package}/${total_packages}]"
        cargo install "$package" 

        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓${NONE} Successfully installed $package"
        else
            echo -e "${RED}✗${NONE} Failed to install $package"
        fi
    done

    # Install tokei separately with all features
    current_package=$((current_package + 1))
    echo -e "\n${YELLOW}Installing${NONE} tokei with all features [${current_package}/${total_packages}]"
    (cargo install tokei --features all >>"$log_file" 2>&1) &
    spinner $!

    # Install bat-extras
    echo -e "\n${CYAN}Installing bat-extras...${NONE}"

    BAT_EXTRAS_DIR="$HOME/Documents/Github/OtherGits/bat-extras"

    # Create directories if they don't exist
    if ! mkdir -p "$HOME/Documents/Github/OtherGits/"; then
        echo -e "${RED}Failed to create directories!${NONE}"
        return 1
    fi

    # Clone or update bat-extras
    if [ -d "$BAT_EXTRAS_DIR" ]; then
        echo "Updating existing bat-extras installation..."
        (cd "$BAT_EXTRAS_DIR" && git pull) || echo -e "${RED}Failed to update bat-extras${NONE}"
    else
        echo "Cloning bat-extras..."
        git clone https://github.com/eth-p/bat-extras.git "$BAT_EXTRAS_DIR" || {
            echo -e "${RED}Failed to clone bat-extras${NONE}"
            return 1
        }
    fi

    # Build and install bat-extras
    (cd "$BAT_EXTRAS_DIR" && sudo ./build.sh --install --manuals) || {
        echo -e "${RED}Failed to build/install bat-extras${NONE}"
        return 1
    }

    # Installation complete
    echo -e "\n${GREEN}${BOLD}Cargo package installation complete!${NONE}"
    echo -e "${YELLOW}Consider installing atuin from https://github.com/atuinsh/atuin${NONE}"

    # Show installation summary
    echo -e "\n${CYAN}Installation Summary:${NONE}"
    echo -e "Total packages processed: $total_packages"
    echo -e "Log file: $log_file"
    echo -e "Bat-extras location: $BAT_EXTRAS_DIR"

    pause "Press [Enter] to continue to main menu"
}
