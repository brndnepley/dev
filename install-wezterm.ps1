function Test-CommandExists {
    param ([string] $Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

function Install-WezTermMac {
    Write-Host "Installing WezTerm on macOS..."
} 

function Install-WezTermWindows { 

    if (-not (Test-CommandExists winget)) {
        Write-Host "winget is not installed. Please install from the MicroSoft Store"
        exit 1
    }

    Write-Host "Installing WezTerm on Windows..."
    winget install wez.wezterm --silent
}

function Install-WezTermLinux {
    Write-Host "Installing WezTerm on Linux..."

    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list

    sudo apt update
    sudo apt install -y wezterm-nightly
}

function Copy-WezTermConfig {
    if (Test-Path "./.wezterm.lua") {
        Copy-Item "./.wezterm.lua" -Destination "$HOME/.wezterm.lua" -Force
        Write-Host "WezTerm config (.wezterm.lua) copied to $HOME"
    }
    else {
        Write-Host "No WezTerm config file (.wezterm.lua) file found in repo."
    }
}

function Test-WeztermExists {
    if (Test-CommandExists "wezterm") {
        Write-Host "WezTerm installed successfully!"
    }
    else {
        Write-Host "Could not find wezterm command, try restarting terminal."
    }
}

# run
switch ($true) {
    $IsWindows {
        Install-WezTermWindows
    }
    $IsLinux {
        Install-WezTermLinux
    }
    Default {
        Write-Host "Unsupported OS: $([System.Environment]::OSVersion.Platform)"
        exit 1
    }
}

Copy-WezTermConfig
