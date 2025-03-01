$appName = "Oh My Posh"
$appCmd = "oh-my-posh"

function Test-CommandExists {
    param ([string] $Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

function Update-PowerShellProfile {
    param ([string] $file)
    $poshTheme = "$PSScriptRoot/posh_themes/amro.omp.json"
    $profileContent = Get-Content $file
    $updated = $profileContent | ForEach-Object {
        if ($_ -match "$appCmd init pwsh") {
            oh-my-posh init pwsh --config $poshTheme | Invoke-Expression
        }
        else {
            $_
        }
    }

    $updated | Set-Content $file
    Write-Host "Updated PowerShell profile: $file"
}

function Install-OhMyPoshMac {
    Write-Host "Installing $appName on Windows..."
}

function Install-OhMyPoshWindows {
    if (Test-IsInstalled $appName) {
        Write-Host "$appName is installed. Upgrading..."
        winget upgrade JanDeDobbeleer.OhMyPosh -s winget
    }
    else {
        Write-Host "Installing $appName on Windows..."
        Write-Host "Downloading installation script"
        winget install JanDeDobbeleer.OhMyPosh -s winget
    }

    if (Test-IsInstalled $appName) {
        Write-Host "$appName installed. Adding $appCmd to PATH."
        $lad = [Environment]::GetFolderPath([Environment+SpecialFolder]::LocalApplicationData)
        $env:PATH += ";$lad\Programs\oh-my-posh\bin\"
    }
    else {
        Write-Host "$appName not installed."
        exit 1;
    }
}

function Install-OhMyPoshLinux {
    Write-Host "Installing $appName on Linux..."
    if (!(Test-CommandExists oh-my-posh)) {
        Write-Host "Downloading installation script"
        curl -s https://ohmyposh.dev/install.sh | bash -s
    }
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

# run
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

Update-PowerShellProfile $PROFILE

if (Test-CommandExists $appCmd) {
    Write-Host "$appCmd command found."
    Write-Host "Installing fonts..."
    oh-my-posh font install "CascadiaCode"
}
else {
    Write-Host "$appCmd command not found."
}

