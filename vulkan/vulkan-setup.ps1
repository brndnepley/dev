switch ($true) {
	$IsWindows {
		$platform = "windows"
		$file = "vulkan_sdk.exe"
		$vulkanLoc = "$HOME/vulkan"
	}
	$IsLinux {
		$platform = "linux"
		$file = "vulkan_sdk.tar.xz"
		$vulkanLoc = "$HOME/vulkan"
	}
	Default {
		Write-Host "(Copy-NeovimConfig) Unsupported OS: $([System.Environment]::OSVersion.Platform)"
		exit 1
	}
}

function Show-Latest-SDK {
	param ([string]$platform)
	if (!$platform) {
		return
	}
	Write-Host "Checking for latest SDK verion..."
	curl -s https://vulkan.lunarg.com/sdk/latest/$platform.txt
}

function Get-VulkanSDK-Latest {
	$version = Show-Latest-SDK($platform)

	Write-Host "Downloading Vulkan SDK ..."
	Write-Host $platform
	Write-Host $version
	Write-Host $file

	if (!(Test-Path $vulkanLoc)) {
		mkdir $vulkanLoc
	}
	Push-Location $vulkanLoc
	curl -sO https://sdk.lunarg.com/sdk/download/$version/$platform/$file
	
	Write-Host "Comparing SHA hashes..."
	$h1 = curl -s https://sdk.lunarg.com/sdk/sha/$version/$platform/$file.txt
	$computed = Get-FileHash -Path $vulkanLoc/$file -Algorithm SHA256

	if ($computed.Hash -ieq $h1.Split(" ")[0]) {
		Write-Host "MATCH"

		if ($IsLinux) {
			Write-Host "Extracting tarball..."
			tar -xvf $file
		}

		$Env:VULKAN_CUSTOM_INSTALL_DIR = "$vulkanLoc/$version/x86_64"

		Write-Host "Installing runtime deps"
		sudo apt install libxcb-xinput0 libxcb-xinerama0 libxcb-cursor-dev
	}
	else {
		Write-Host "NO MATCH"
		Write-Host "Exiting SDK installation."
	}

	Pop-Location
	return
}
