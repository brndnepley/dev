#!/bin/bash
mkdir tmp
curl -L https://dot.net/v1/dotnet-install.sh -o tmp/dotnet-install.sh
chmod +x ./tmp/dotnet-install.sh

./tmp/dotnet-install.sh --channel 9.0 --version latest --os linux

rc="$HOME/.bashrc"

export DOTNET_ROOT=$HOME/.dotnet
l1="export DOTNET_ROOT=\"\$HOME/.dotnet\""
grep -qxF "$l1" "$rc" || echo "$l1" >> "$rc"

# the path here is set from the curl'd script
l1="export PATH=\"\$PATH:\$DOTNET_ROOT\""
grep -qxF "$l1" "$rc" || echo "$l1" >> "$rc"

export PATH="$PATH:$DOTNET_ROOT/tools"
l1="export PATH=\"\$PATH:\$DOTNET_ROOT/tools\""
grep -qxF "$l1" "$rc" || echo "$l1" >> "$rc"

. "$rc"

dotnet tool install --global PowerShell
