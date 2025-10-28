# Invokes a Cmd.exe shell script and updates the environment.
function Invoke-CmdScript {
  param([String] $scriptName)

	if ($IsWindows) {
	  $cmdLine = """$scriptName"" $args & set"
	  & $Env:SystemRoot\system32\cmd.exe /c $cmdLine |
	  select-string '^([^=]*)=(.*)$' | foreach-object {
		$varName = $_.Matches[0].Groups[1].Value
		$varValue = $_.Matches[0].Groups[2].Value
		set-item Env:$varName $varValue
	  }
	}
}

# Sets up visual studio MSVC C/C++ vars
function Set-Vars {
    $vcvarsallPath = "${Env:ProgramFiles}\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat"
    Invoke-CmdScript $vcvarsallPath "x64"
}
