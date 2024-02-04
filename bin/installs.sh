#!/usr/bin/env bash

set -eu -o pipefail

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

sudo apt update
sudo apt install software-properties-common wget build-essential pkg-config libcairo2-dev gcc libgirepository1.0-dev xfce4 xfce4-goodies python3-pip apt-transport-https python3-dev update-manager font-manager nautilus -y
sudo apt install xrdp -y
sudo usermod -a -G ssl-cert xrdp
echo "xfce4-session" | tee .xsession
sudo systemctl restart xrdp

wget -O- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg
echo deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install code-insiders

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y

pip install PyGObject
wget -qO- https://raw.githubusercontent.com/cra0zy/code-nautilus/master/install.sh | bash

curl -fsSLo Miniforge3.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname -s)-$(uname -m).sh"
bash Miniforge3.sh -b -p "${HOME}/miniforge"

sudo apt install thefuck btop fzf tldr -y
