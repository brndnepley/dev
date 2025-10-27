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
