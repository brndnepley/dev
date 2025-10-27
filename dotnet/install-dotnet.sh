#!/bin/bash
#
# Downloads and runs the dotnet-install.sh script from Microsoft
#
# More info here:
# https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script

mkdir tmp
curl -L https://dot.net/v1/dotnet-install.sh -o tmp/dotnet-install.sh
chmod +x ./tmp/dotnet-install.sh

./tmp/dotnet-install.sh --channel 9.0 --version latest --os linux
./tmp/dotnet-install.sh --channel 10.0 --version latest --os linux

rc="$HOME/.bashrc"

export DOTNET_ROOT=$HOME/.dotnet
l1	="export DOTNET_ROOT=\"\$HOME/.dotnet\""
grep -qxF "$l1" "$rc" || echo "$l1" >> "$rc"

# the path here is set from the curl'd script
l1="export PATH=\"\$PATH:\$DOTNET_ROOT\""
grep -qxF "$l1" "$rc" || echo "$l1" >> "$rc"

export PATH="$PATH:$DOTNET_ROOT/tools"
l1="export PATH=\"\$PATH:\$DOTNET_ROOT/tools\""
grep -qxF "$l1" "$rc" || echo "$l1" >> "$rc"

# install mono
sudo apt install ca-certificates gnupg
sudo gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/mono-official-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb [signed-by=/usr/share/keyrings/mono-official-archive-keyring.gpg] https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update

. "$rc"
