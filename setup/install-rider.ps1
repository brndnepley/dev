function Install-RiderLinux {
    #TODO check for snap
    #TODO check for already installed
    Write-Host "Installing JetBrains Rider for Linux with snap"
    sudo snap install rider --classic
    Write-Host "Done!"
}

function Install-Rider {
    switch ($true) {
        $IsWindows {
        }
        $IsLinux {
            Install-RiderLinux
        }
    }
}

Install-Rider
