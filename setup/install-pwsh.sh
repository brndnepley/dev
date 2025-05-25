#!/bin/bash

command_exists() {
    command -v "$1" &>/dev/null
}

install_powershell_debian() {
    # Debian/Ubuntu-based
    echo "Installing PowerShell for Debian/Ubuntu..."
    source /etc/os-release && echo "Current Ubuntu version: $PRETTY_NAME"

    sudo apt update || \
        { echo "Failed to update package list."; exit 1; }
    sudo apt install -y wget apt-transport-https software-properties-common || \
        { echo "Failed to install dependencies"; exit 1; }
    wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb || \
        { echo "Failed to download Microsoft repository keys."; exit 1; }
    sudo dpkg -i packages-microsoft-prod.deb || \
        { echo "Failed to register the Microsoft repository keys."; exit 1; }

    # remove installation files when done
    rm packages-microsoft-prod.deb

    sudo apt update
    sudo apt install -y powershell 
}

install_powershell_linux() {
    if command_exists apt; then
        install_powershell_debian
    else
        echo "Unsupported Linux distribution. Please install PowerShell manually."
        exit 1
    fi
}

install_powershell_mac() {
    echo "Installing PowerShell on macOS..."
    if ! command_exists brew; then
        echo "Homebrew is not installed. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    # Update Homebrew
    brew update
    # Install PowerShell
    brew install powershell/tap/powershell
}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    install_powershell_linux
elif [[ "OSTYPE" == "darwin"* ]]; then
    install_pwsh_mac_os
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi

# Verify installation
if command -v pwsh &>/dev/null; then
    echo "PowerShell installation successful!"
else
    echo "PowerShell installation failed."
    exit 1
fi
