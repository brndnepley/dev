function Test-OhMyPosh {
    if (Test-CommandExists "oh-my-posh") {
        oh-my-posh init pwsh | Invoke-Expression
    }
}

function Test-Fnm {
    if (!(Test-CommandExists "fnm")) {
        switch ($true) {
            $IsWindows {
            }
            $IsLinux {
                $Env:PATH += ":$HOME/.local/share/fnm"
            }
            Default {
            }
        }
    }
    fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
}

# source utils
$profileFolder = Split-Path -Path $PROFILE -Parent
. $profileFolder/setup-utils.ps1
. $profileFolder/setup-win-utils.ps1
. $profileFolder/env-vars.ps1

Test-OhMyPosh

$PSStyle.FileInfo.Directory = "`e[34;1m"
