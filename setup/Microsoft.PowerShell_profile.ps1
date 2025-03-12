function Test-CommandExists {
    param ([string] $Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

function Prompt {
    switch ($true) {
        $IsWindows {
            $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
            $principal = [Security.Principal.WindowsPrincipal] $identity
            $adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

            $prefix = if (Test-Path variable:/PSDebugContext) { '[DBG]: ' } else { '' }
            if ($principal.IsInRole($adminRole)) {
                $prefix = "[ADMIN]:$prefix"
            }
            $body = 'PS ' + $PWD.path
            $suffix = $(if ($NestedPromptLevel -ge 1) { '>>' }) + '> '
            "${prefix}${body}${suffix}"
        }
        $IsLinux {
            $Esc = [char]27
            $ResetColor = $Esc
            "$Esc PS $(Get-Date) $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1))";
        }
    }
}

if ($HOST.Name -eq "ConsoleHost") {
    function ls_col { & "/usr/bin/ls" --color=always $args }
    Set-Alias -Name ls -Value ls_col -Option AllScope
}

if (Test-CommandExists "oh-my-posh") {
    oh-my-posh init pwsh | Invoke-Expression
}

$PSStyle.FileInfo.Directory = "`e[34;1m"
