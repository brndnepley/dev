#!/bin/bash
command_exists() {
    command -v "$1" &>/dev/null
}

install_on_ubuntu() {
    # Debian/Ubuntu-based
    echo "Installing PowerShell..."

	# Get Ubuntu version
    source /etc/os-release && echo "Current OS version: $PRETTY_NAME"

	echo "Running apt-get update quietly..."
    sudo apt-get update -qq || \
        { echo "Failed to update package list."; exit 1; }

	# Install pre-reqs
    sudo apt-get install -y wget apt-transport-https software-properties-common || \
        { echo "Failed to install dependencies"; exit 1; }

	# Download the Microsoft repo keys
    wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb || \
        { echo "Failed to download Microsoft repository keys."; exit 1; }

	# Regiseter the Microsoft repo keys
    sudo dpkg -i packages-microsoft-prod.deb || \
        { echo "Failed to register the Microsoft repository keys."; exit 1; }

    # Delete repo keys when done
    rm packages-microsoft-prod.deb

	# install
    sudo apt-get update -qq
    sudo apt-get install -y powershell 
}

install_on_mac() {
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

# run
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command_exists apt; then
        install_on_ubuntu
    else
        echo "Unsupported Linux distribution. Please install PowerShell manually."
        exit 1
    fi
elif [[ "OSTYPE" == "darwin"* ]]; then
    install_on_mac
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi

# verify
if command -v pwsh &>/dev/null; then
    echo "PowerShell installation successful!"
else
    echo "PowerShell installation failed."
    exit 1
fi
