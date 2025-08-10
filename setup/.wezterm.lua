local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- prefer_egl = true -- use this for virtual box systems 
-- aarch64-apple-darwin for Apple silicon
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh.exe" }
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
	config.default_prog = { "pwsh", "-NoLogo" }
end

config.font = wezterm.font_with_fallback({
	"CaskaydiaCove NFM",
	"Cascadia Mono",
	"JetBrains Mono",
	"Fira Code",
})

config.font_size = 14.0

config.color_schemes = {
	["gnome"] = {
		foreground = "#D0CFCC",
		background = "#171421",
		cursor_fg = "#49B9C7",
		cursor_bg = "#F6F6F6",
		ansi = {
			"#171421",
			"#C01C28",
			"#26A269",
			"#A2734C",
			"#12488B",
			"#A347BA",
			"#2AA1B3",
			"#D0CFCC",
		},
		brights = {
			"#8978BD",
			"#F66151",
			"#33D17A",
			"#E9AD0C",
			"#2A7BDE",
			"#C061CB",
			"#33C7DE",
			"#FFFFFF",
		},
	},
}

config.color_scheme = "gnome"

return config
