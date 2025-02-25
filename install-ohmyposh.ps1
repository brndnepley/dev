function Test-CommandExists {
    param ([string] $Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

function Install-OhMyPoshMac {
    Write-Host "Installing Oh My Posh on Windows..."
}

function Install-OhMyPoshWindows {
    Write-Host "Installing Oh My Posh on Windows..."
    if (!(Test-CommandExists oh-my-posh)) {
        Write-Host "Downloading installation script"
        winget install JanDeDobbeleer.OhMyPosh -s winget
    }
    else {
        Write-Host "Oh My Posh already installed. Upgrading instead..."
        winget upgrade JanDeDobbeleer.OhMyPosh -s winget
    }
}

function Install-OhMyPoshLinux {
    Write-Host "Installing Oh My Posh on Linux..."
    if (!(Test-CommandExists oh-my-posh)) {
        Write-Host "Downloading installation script"
        curl -s https://ohmyposh.dev/install.sh | bash -s
    }
}

switch ($true) {
    $IsWindows {
        Install-OhMyPoshWindows
    }
    $IsLinux {
        Install-OhMyPoshLinux
    }
    Default {
        Write-Host "Unsupported OS: $([System.Environment]::OSVersion.Platform)"
        exit 1
    }
}

if (Test-CommandExists oh-my-posh) {
    Write-Host "Oh My Posh installed successfully."
    #install fonts
    Write-Host "Installing fonts..."
    oh-my-posh font install "CascadiaCode"

    #$omp = "oh-my-posh init pwsh | Invoke-Expression"
    #if (!(Select-String -Path $PROFILE -Pattern ([regex]::Escape($omp)) -Quiet)) {
    #    #append to profile.ps1
    #    Add-Content -Path $PROFILE -Value "`n$omp`n"
    #    Write-Host "Appended Oh My Posh init command to profile (.ps1) file."
    #    . $PROFILE
    #}
}
else {
    Write-Host "Oh My Posh installation failed."
}
