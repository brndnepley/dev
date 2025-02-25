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

    $poshTheme = "$PSScriptRoot/posh_themes/amro.omp.json"

    $profileContent = Get-Content $PROFILE
    $updated = $profileContent | ForEach-Object {
        if ($_ -match "oh-my-posh init pwsh") {
            "oh-my-posh init pwsh --config $poshTheme | Invoke-Expression"
        }
        else {
            $_
        }
    }

    $updated | Set-Content $PROFILE
    Write-Host "Updated PowerShell profile: $PROFILE"
    . $PROFILE
}
else {
    Write-Host "Oh My Posh installation failed."
}
