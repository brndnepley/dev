function Test-CommandExists {
    param ([string] $Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

function Test-IsInstalled {
    param ([string] $name)

    Write-Host "Checking winget for $name installation..." 
    $installed = winget list --name $name | Select-Object -Last 1

    if ($installed.Contains("No installed package found")) {
        Write-Host "$name not found."
        return $false
    }
    else {
        Write-Host "$name found."
        return $true
    }
}

function Test-FontExists {
    param ([string] $FontFolder)
    if (Test-Path -Path $FontFolder) {
        $true
    }
    else {
        $false
    }
}

function Copy-ConfigFile {
    param ([string] $DestPath,
		   [string] $ToPath)

    if (Test-Path $DestPath) {
        Copy-Item $DestPath -Destination $ToPath -Force
        Write-Host "Config copied to $ToPath"
    }
    else {
        Write-Host "Source config file $DestPath not found."
    }
}

function Remove-DuplicatePathEntries {
    $seen = @{}
    $unique = @()
	$splitChar = ':'

    foreach ($entry in $Env:PATH -split $splitChar) {
        $normalized = [System.IO.Path]::GetFullPath($entry).ToLowerInvariant()
        if (-not $seen.ContainsKey($normalized)) {
            $seen[$normalized] = $true
            $unique += $entry
        }
    }

    $Env:PATH = ($unique -join ':')
	Write-Host "Cleaned PATH:"
	foreach ($path in $unique) {
		Write-Host $path
	}
}

function Set-lsColorAlias {
    if ($HOST.Name -eq "ConsoleHost") {
        function ls_col { & "/usr/bin/ls" --color=always $args }
        Set-Alias -Name ls -Value ls_col -Option AllScope
    }
}

function Add-LineIfMissing() {
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath,

        [Parameter(Mandatory=$true)]
        [string]$ContentToAdd
    )

    if (-not (Test-Path $FilePath)) {
        Write-Error "File not found: $FilePath"
        return
    }

    $lines = Get-Content $FilePath
    if ($lines -notcontains $ContentToAdd) {
        Add-Content -Path $FilePath -Value $ContentToAdd
        Write-Host "Added line: '$ContentToAdd'"
    }
}
