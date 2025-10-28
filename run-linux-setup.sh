#!/bin/bash

# Installs powershell and run the setup script
# on linux, when powershell is not initially available

. ./powershell/install-pwsh.sh

if command -v pwsh >/dev/null 2>&1; then
	echo "Running setup (powershell script)..."
	pwsh -NoProfile -File ./run-setup.ps1
else
	echo "Could not complete linux setup. Exiting."
fi
