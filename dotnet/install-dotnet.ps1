. ../utils/setup-utils.ps1

$sdk = "dotnet-sdk-9.0"
$runtime = "aspnetcore-runtime-9.0"
$appCmd = "dotnet"

function Install-DotnetSdkLinux() {
	# Debian/Ubuntu based install
	Write-Host "Installing dotnet..."

	# Add microsoft Ubuntu .NET backports
	sudo add-apt-repository ppa:dotnet/backports

	sudo apt-get update
    sudo apt-get install -y $runtime
	sudo apt-get install -y $sdkVersion
}

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
