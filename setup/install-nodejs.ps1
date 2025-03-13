. ./setup-utils.ps1

$appCmd = "node"
$nodeVersion = "22"

function Install-NodeWindows {
    # Download and install fnm:
    winget install Schniz.fnm

    # Download and install Node.js:
    fnm install $nodeVersion

    # Verify the Node.js version:
    node -v # Should print "v22.14.0".

    # Verify npm version:
    npm -v # Should print "10.9.2".
}

# run
switch ($true) {
    $IsWindows {
        Install-NodeWindows
        #$Env:PATH += ";$HOME/.local/share/fnm/"
    }
    $IsLinux {
        if (Test-CommandExists "fnm") {
            Write-Host "'fnm' already installed."
        }
        else {
            Write-Host "Running Node bash install..."
            bash ./install-nodejs.sh
            $Env:PATH += ":$HOME/.local/share/fnm/"
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
