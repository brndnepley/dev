$sdk = "dotnet-sdk-9.0"
$runtime = "aspnetcore-runtime-9.0"
$appCmd = "dotnet"

function Install-DotnetLinux() {
	# Debian/Ubuntu based install
	# Update packages
	Write-Host "Installing dotnet..."

	# Add microsoft Ubuntu .NET backports repository
	sudo add-apt-repository ppa:dotnet/backports
	Write-Host "Running apt-get update quitely..."
	sudo apt-get update -qq

	# To remove repo
	# sudo add-apt-repository --remove ppa:dotnet/backports

	Write-Host "Installing $sdk..."
	sudo apt-get install $sdk

	Write-Host "Installing $runtime..."
    sudo apt-get install $runtime
}

# run
. ./utils/setup-utils.ps1

switch ($true) {
	$IsWindows {
	}
	$IsLinux {
		Install-DotnetLinux
	}
	Default {
        Write-Host "Unsupported OS: $([System.Environment]::OSVersion.Platform)"
        exit 1
	}
}

if (Test-CommandExists $appCmd) {
    Write-Host "$appCmd command found."
}
else {
    Write-Host "$appCmd command not found."
}
