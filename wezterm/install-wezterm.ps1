$appName = "WezTerm"
$appCmd = "wezterm"

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
        $Env:PATH += ";$pf\WezTerm\"
    }
    else {
        Write-Host "$appName not installed."
        exit 1;
    }
}

function Install-WezTermLinux {
    if (Test-CommandExists $appCmd) {
        Write-Host "$appCmd command found."
        Write-Host "Updating WezTerm on Linux..."
		Write-Host "Running apt-get update quietly..."
        sudo apt-get update -qq
        sudo apt-get install --only-upgrade -y wezterm-nightly
    }
    else {
        Write-Host "$appCmd command not found."
        Write-Host "Installing WezTerm on Linux..."
        curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
        echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
		Write-Host "Running apt-get update quietly..."
        sudo apt-get update
        sudo apt-get install -y wezterm-nightly
    }
}

# run
. ./utils/setup-utils.ps1

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

if (Test-CommandExists $appCmd) {
    Write-Host "$appCmd command found."
}
else {
    Write-Host "$appCmd command not found."
}
