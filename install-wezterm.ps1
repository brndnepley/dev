$appName = "WezTerm"
$appCmd = "wezterm"

function Test-CommandExists {
    param ([string] $Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

function Test-IsInstalled {
    param ([string] $name)
    Write-Host "Checking for $name installation..."
    $installed = winget list --name $name | Select-Object -Last 1

    if ($installed.Contains("No installed package found")) {
        Write-Host "$name not found."
        return $false
    }
    else {
        Write-Host "$name found."
        return $true
    }
}

function Copy-WezTermConfig {
    if (Test-Path "./.wezterm.lua") {
        Copy-Item "./.wezterm.lua" -Destination "$HOME/.wezterm.lua" -Force
        Write-Host "$appName config (.wezterm.lua) copied to $HOME"
    }
    else {
        Write-Host "No $appName config file (.wezterm.lua) file found in repo."
    }
}

function Install-WezTermMac {
    Write-Host "Installing $appName on macOS..."
} 

function Install-WezTermWindows { 

    if (Test-IsInstalled $appName) {
        Write-Host "$appName is installed. Upgrading..."
        winget upgrade wez.wezterm
    }
    else {
        Write-Host "Installing $appName on Windows..."
        winget install wez.wezterm
    }

    if (Test-IsInstalled $appName) {
        Write-Host "$appName installed. Adding $appCmd to PATH."
        $pf = [Environment]::GetFolderPath([Environment+SpecialFolder]::ProgramFiles)
        $env:PATH += ";$pf\WezTerm\"
    }
    else {
        Write-Host "$appName not installed."
        exit 1;
    }
}

function Install-WezTermLinux {
    Write-Host "Installing WezTerm on Linux..."

    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list

    sudo apt update
    sudo apt install -y wezterm-nightly
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

if (Test-CommandExists $appCmd) {
    Write-Host "$appCmd command found."
}
else {
    Write-Host "$appCmd command not found."
}
