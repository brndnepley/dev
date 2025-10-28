# TODO: move to program specific setup eventually
switch ($true) {
	$IsWindows {
		$Env:PATH += ";${Env:ProgramFiles(x86)}\GnuWin32\bin" # make
		$Env:PATH += ";${Env:ProgramFiles}\CMake\bin" # cmake
		$Env:PATH += ";${Env:ProgramFiles}\LLVM\bin" # clang
	}
	$IsLinux {
		$Env:PATH += ":$HOME/.local/bin"
		$Env:PATH += ":$HOME/repos/lsp/lua-language-server/bin"
		$Env:PATH += ":$HOME/repos/lsp/omnisharp"

		# clang
		# TODO automate
		$Env:PATH += ":$HOME/repos/llvm-project/build/bin/"

		# vulkan
		# TODO automate 
		$version = "1.4.321.1"
		$vulkanLoc = "$HOME/vulkan/$version"
		$Env:VULKAN_SDK = "$vulkanLoc/x86_64"
		$Env:LD_LIBRARY_PATH = "$Env:VULKAN_SDK/lib"
		$Env:VK_ADD_LAYER_PATH = "$Env:VULKAN_SDK/share/vulkan/explicit_layer.d"
		$Env:VK_LAYER_PATH = "$Env:VULKAN_SDK/share/vulkan/explicit_layer.d"
		$Env:PATH += ":$Env:VULKAN_SDK/bin"
	}
	Default {
	}
}
