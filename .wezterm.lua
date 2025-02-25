local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- aarch64-apple-darwin for Apple silicon
if wezterm.target_triple == "x86_64-pc-winows-msvc" then
	config.default_prog = { "pwsh.exe" }
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
	config.default_prog = { "pwsh" }
end

config.color_scheme = "Chalk"
config.font = wezterm.font_with_fallback({
	"CaskaydiaCove Nerd Font Mono",
	"Fira Code",
	"JetBrains Mono",
})

return config
