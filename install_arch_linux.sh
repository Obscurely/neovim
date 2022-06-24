#!/bin/bash

#
# Install neovim (basically the whole scope of the project
#
sudo pacman -Sy neovim --noconfirm --needed
mkdir $HOME/.config/nvim # create nvim dir .config in case the installer didn't

#
# NVChad Installation
#

git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

#
# Configs dependencies setup
#

# Packages to install

deps=(
  'ripgrep' # for telescope to work
  'xclip'   # for clipboard to work with system
  'npm'     # for installing some LSPs
)

languages=(
  'python3'
  'python3-pip' # manager python deps
  'lua'
  'cmake'
  'dotnet-sdk'
  'jdk-openjdk'
  'rustup'
  'go'
)

lsp_pacman=(
  'clang'
  'rust-analyzer'
  'lua-language-server'
  'pyright'
  'gopls'
  'yaml-language-server'
)

lsp_yay=(
  'java-language-server'
  'cmake-language-server'
)

lsp_npm=(
  'vscode-langservers-extracted'
  'typescript'
  'typescript-language-server'
  'bash-language-server'
  'remark-language-server'
  'remark'
  '@taplo/cli'
)

lsp_dotnet=(
  'csharp-ls'
)

formatter_pacman=(
  'prettier'
  'shfmt'
)

formatter_yay=(
  'python-black-git'
)

formatter_npm=(
  'lua-fmt'
)

#
# Installation
#

# Sync repos
sudo pacman -Sy --noconfirm

# deps
for PKG in "${deps[@]}"; do
  echo "INSTALLING: ${PKG}"
  sudo pacman -S "$PKG" --noconfirm --needed
done

# languages
for PKG in "${languages[@]}"; do
  echo "INSTALLING: ${PKG}"
  sudo pacman -S "$PKG" --noconfirm --needed
done

# lsp pacman
for PKG in "${lsp_pacman[@]}"; do
  echo "INSTALLING: ${PKG}"
  sudo pacman -S "$PKG" --noconfirm --needed
done

# lsp yay
for PKG in "${lsp_yay[@]}"; do
  echo "INSTALLING: ${PKG}"
  yay -S "$PKG" --noconfirm --needed
done

# lsp npm
for PKG in "${lsp_npm[@]}"; do
  echo "INSTALLING: ${PKG}"
  sudo npm i -g "$PKG"
done

# lsp dotnet
for PKG in "${lsp_dotnet[@]}"; do
  echo "INSTALLING: ${PKG}"
  sudo dotnet tool install --global "$PKG"
done

# formatter pacman
for PKG in "${formatter_pacman[@]}"; do
  echo "INSTALLING: ${PKG}"
  sudo pacman -S "$PKG" --noconfirm --needed
done

# formatter yay
for PKG in "${formatter_yay[@]}"; do
  echo "INSTALLING: ${PKG}"
  yay -S "$PKG" --noconfirm --needed
done

# formatter npm
for PKG in "${formatter_npm[@]}"; do
  echo "INSTALLING: ${PKG}"
  sudo npm i -g "$PKG"
done

#
# Copy configs
#

mkdir $HOME/.config/nvim/lua/custom/ # dir where configs go

cp -r * $HOME/.config/nvim/lua/custom/

echo "!!!WARNING!!!"
echo "First run of neovim must be done with the following command"
echo "nvim +'hi NormalFloat guibg=#1e222a' +PackerSync"
