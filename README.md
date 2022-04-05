# Lunar vim configuration
This is my quite simple neovim setup that is based on the already great [Lunar Vim](https://github.com/LunarVim/LunarVim) project. This is just the settings made extra besides the defaults that make the setup as close as I could to the functionallity I was used in VSCode. It's not perfect, but it seems to be working fine. I will update it once I make new changes or add other things.

## Installation procces
### 1.Install Lunar Vim
Refer to https://www.lunarvim.org/01-installing.html#prerequisites for installation instructions and make sure you install all the dependencies.

### 2.You should be able to run it by executing $HOME/.local/bin/lvim
Or just by running lvim if you have .local/bin in path... If so what I like to do is just make an alias in zshrc (or your shell's rc file) to nvim

### 3.Install dependencies for the config it's self
The dependencies are: dotnet-sdk, rustup, black, rust-analyzer, prettier, code-minimap, glow, ripgrep

For Arch Linux you can install them like this:
From pacman
```shell
sudo pacman -Sy dotnet-sdk rustup rust-analyzer prettier glow ripgrep python3 python3-pip xclip --needed
```
From AUR (with yay)
```shell
yay -Sy code-minimap
```
From pip
```shell
pip install black
```
### 4.Starting it up with nvim command and happy coding!
