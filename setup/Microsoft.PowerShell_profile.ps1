function Set-lsColorAlias {
    if ($HOST.Name -eq "ConsoleHost") {
        function ls_col { & "/usr/bin/ls" --color=always $args }
        Set-Alias -Name ls -Value ls_col -Option AllScope
    }
}

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

function Set-Env {
    switch ($true) {
        $IsWindows {
        }
        $IsLinux {
            $Env:PATH += ":$HOME/.dotnet"
            $Env:DOTNET_ROOT = "$HOME/.dotnet"
        }
        Default {
        }
    }
}

Set-lsColorAlias
Test-OhMyPosh
Test-Fnm
Set-Env

$PSStyle.FileInfo.Directory = "`e[34;1m"
