function Copy-NeovimConfig {
    # neovim config default locations
    # Unix    ~/.config/nvim/init.lua
    # Windows ~/AppData/Local/nvim/init.lua
    switch ($true) {
        $IsWindows {
            $configDest = [Environment]::GetFolderPath([Environment+SpecialFolder]::LocalApplicationData)
            $configDest += "\nvim\"
        }
        $IsLinux {
            $configDest = "$HOME/.config/nvim/"
        }
        Default {
            Write-Host "Unsupported OS: $([System.Environment]::OSVersion.Platform)"
            exit 1
        }
    }

    if (Test-Path "./neovim/neovimrc/init.lua") {
        Copy-Item -Path "./neovim/neovimrc/*" -Destination $configDest -Recurse -Force
        Write-Host "Neovim config copied to $configDest"
    }
    else {
        Write-Host "No Neovim config file (init.lua) file found in repo."
    }
}
