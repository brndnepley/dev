function Test-CommandExists {
    param ([string] $Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

function Test-IsInstalled {
    param ([string] $name)

    Write-Host "Checking for $name installation..." 
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
    $split = $Env:PATH -split ';'
    $cleaned = $split | Sort-Object -Unique
    $newPath = $cleaned -join ';'
    $Env:PATH = $newPath
}
