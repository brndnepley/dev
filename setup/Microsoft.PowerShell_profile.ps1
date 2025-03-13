if ($HOST.Name -eq "ConsoleHost") {
    function ls_col { & "/usr/bin/ls" --color=always $args }
    Set-Alias -Name ls -Value ls_col -Option AllScope
}

$old = $ErrorActionPreference
$ErrorActionPreference = "SilentlyContinue"

if (Test-CommandExists "oh-my-posh") {
    oh-my-posh init pwsh | Invoke-Expression
}

if (!(Test-CommandExists "fnm")) {
    switch ($true) {
        $IsWindows {
        }
        $IsLinux {
            $Env:PATH += ":$HOME/.local/share/fnm"
            fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
        }
        Default {
        }
    }
}
else {
    fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
}

$PSStyle.FileInfo.Directory = "`e[34;1m"
$ErrorActionPreference = $old
