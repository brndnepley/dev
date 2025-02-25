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
    winget install wez.wezterm

    if (Test-CommandExists wezterm) {
        Write-Host "WezTerm installed successfully!"
    }
    else {
        Write-Host "WezTerm installation failed."
    }
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

function Copy-PowerShellConfig {
    param ([string] $ToPath)

    $srcFile = "Microsoft.PowerShell_profile.ps1"

    if (!(Test-Path -Path $ToPath)) {
        New-Item -ItemType "file" -Path $ToPath -Force | Out-Null
        Write-Host "Created new Microsoft.PowerShell_profile.ps1 at: $ToPath"
    }

    if (Test-Path $srcFile) {
        Copy-Item $srcFile -Destination $ToPath -Force | Out-Null # Force creates necessary folders when they don't exist
        Write-Host "$srcFile copied to $ToPath"
    }
    else {
        Write-Host "No PowerShell profile config ($srcFile) file found in repo."
    }
}

switch ($true) {
    $IsWindows {
        Install-WezTermWindows
        Copy-WezTermConfig
        Copy-PowerShellConfig $PROFILE
    }
    $IsLinux {
        Install-WezTermLinux
        Copy-WezTermConfig
        Copy-PowerShellConfig $PROFILE
    }
    Default {
        Write-Host "Unsupported OS: $([System.Environment]::OSVersion.Platform)"
        exit 1
    }
}

if (Test-CommandExists "wezterm") {
    Write-Host "WezTerm installed successfully!"
}
else {
    Write-Host "WezTerm installation failed."
}
