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

oh-my-posh init pwsh --config ./posh_themes/amro.omp.json  | Invoke-Expression
