# utils
. ./utils/setup-utils.ps1
$profileDir = Split-Path -Path $PROFILE -Parent
Copy-ConfigFile "./utils/setup-utils.ps1" "$profileDir/setup-utils.ps1"
Copy-ConfigFile "./utils/setup-win-utils.ps1" "$profileDir/setup-win-utils.ps1"
Copy-ConfigFile "./env-vars.ps1" "$profileDir/env-vars.ps1"

# powershell
Copy-ConfigFile "./powershell/Microsoft.PowerShell_profile.ps1" $PROFILE

# wezterm
. ./wezterm/install-wezterm.ps1
Copy-ConfigFile "./wezterm/.wezterm.lua" "$HOME/.wezterm.lua"

# ohmyposh
. ./ohmyposh/install-ohmyposh.ps1

# neovim
# TODO: update to full install on neovim 12 release
. ./neovim/install-neovim.ps1
Copy-NeovimConfig

# nodejs
# . ./install-nodejs.ps1

# vulkan
# . ./vulkan-setup.ps1
