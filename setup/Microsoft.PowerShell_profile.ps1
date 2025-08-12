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

function Invoke-CmdScript {
# Invokes a Cmd.exe shell script and updates the environment.
  param(
    [String] $scriptName
  )
  $cmdLine = """$scriptName"" $args & set"
  & $Env:SystemRoot\system32\cmd.exe /c $cmdLine |
  select-string '^([^=]*)=(.*)$' | foreach-object {
    $varName = $_.Matches[0].Groups[1].Value
    $varValue = $_.Matches[0].Groups[2].Value
    set-item Env:$varName $varValue
  }
}

function Set-Vars {
    $vcvarsallPath = "${Env:ProgramFiles}\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat"
    Invoke-CmdScript $vcvarsallPath "x64"
}

function Set-Env {
    switch ($true) {
        $IsWindows {
            $Env:PATH += ";${Env:ProgramFiles(x86)}\GnuWin32\bin" # make
            $Env:PATH += ";${Env:ProgramFiles}\CMake\bin" # cmake
            $Env:PATH += ";${Env:ProgramFiles}\LLVM\bin" # clang
        }
        $IsLinux {
			$Env:DOTNET_ROOT = "$HOME/.dotnet"
            $Env:PATH += ":$HOME/.dotnet"
            $Env:PATH += ":$HOME/.dotnet/tools"

            $Env:PATH += ":$HOME/.local/bin"

            $Env:PATH += ":$HOME/repos/lsp/lua-language-server/bin"
			$Env:PATH += ":$HOME/repos/lsp/omnisharp"
        }
        Default {
        }
    }
}

Set-Vars
Set-Env
Set-lsColorAlias
Test-OhMyPosh
Test-Fnm

$PSStyle.FileInfo.Directory = "`e[34;1m"
