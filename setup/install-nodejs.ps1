. ./setup-utils.ps1

$appCmd = "node"
$nodeVersion = "22"

function Install-NodeWindows {
    # Download and install fnm:
    winget install Schniz.fnm 
    $Env:PATH += ";$HOME/.local/share/fnm"
    . $PROFILE
    fnm install $nodeVersion
    node -v
    npm -v
}

# run
switch ($true) {
    $IsWindows {
        if (Test-CommandExists "fnm") {
            Write-Host "'fnm' already installed."
        }
        else {
            Write-Host "Running Node install script..."
	    Install-NodeWindows
        }
    }
    $IsLinux {
        if (Test-CommandExists "fnm") {
            Write-Host "'fnm' already installed."
        }
        else {
            Write-Host "Running Node bash install..."
            bash ./install-nodejs.sh
            $Env:PATH += ":$HOME/.local/share/fnm"
            fnm install $nodeVersion
            . $PROFILE
            node -v
            npm -v
        }
    }
    Default {
        Write-Host "Unsupported OS: $([System.Environment]::OSVersion.Platform)"
        exit 1
    }
}

if (Test-CommandExists "node") {
    Write-Host "$appCmd command found."
}
else {
    Write-Host "$appCmd command not found."
}
