function Copy-NeovimConfig {
    # neovim config default locations
    # Unix    ~/.config/nvim/init.lua
    # Windows ~/AppData/Local/nvim/init.lua
    switch ($true) {
        $IsWindows {
            $configDest = [Environment]::GetFolderPath([Environment+SpecialFolder]::LocalApplicationData)
            $configDest += "\nvim\"
            # TODO install neovim and a c compiler (zig)
        }
        $IsLinux {
            $configDest = "$HOME/.config/nvim/"
        }
        Default {
            Write-Host "(Copy-NeovimConfig) Unsupported OS: $([System.Environment]::OSVersion.Platform)"
            exit 1
        }
    }

    if (Test-Path "../neovimrc/init.lua") {
        Copy-Item -Path "../neovimrc/*" -Destination $configDest -Recurse -Force
        Write-Host "Neovim config copied to $configDest"
    }
    else {
        Write-Host "No Neovim config file (init.lua) file found in repo."
    }
}

Copy-NeovimConfig
